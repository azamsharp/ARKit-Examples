//
//  ViewController.swift
//  ARKitExamples
//
//  Created by Mohammad Azam on 6/16/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

enum BodyType :Int {
    
    case ball = 1
    case barrier = 2
}

class CollisionDetectionViewController: UIViewController, ARSCNViewDelegate, SKPhysicsContactDelegate {
    
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = CollisionScene()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        sceneView.scene = scene
        
        // add the barrier
        let barrier = SCNBox(width: 0.2, height: 0.2, length: 0.1, chamferRadius: 0)
        let barrierMaterial = SCNMaterial()
        barrierMaterial.diffuse.contents = UIColor.green
        barrier.materials = [barrierMaterial]
        
        let barrierNode = SCNNode(geometry: barrier)
        barrierNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        barrierNode.physicsBody?.categoryBitMask = BodyType.barrier.rawValue
        barrierNode.position = SCNVector3(0, 0.1, -1.5)
        
        sceneView.scene.rootNode.addChildNode(barrierNode)
    }
    
    @objc func tapped(recognizer :UIGestureRecognizer) {
        
        guard let currentFrame = self.sceneView.session.currentFrame else {
            return
        }
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.3
        
        let geometry = SCNSphere(radius: 0.05)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        geometry.materials = [material]
        
        let node = SCNNode(geometry: geometry)
        
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node.physicsBody?.isAffectedByGravity = false
        
        node.physicsBody?.categoryBitMask = BodyType.ball.rawValue
        node.physicsBody?.contactTestBitMask = BodyType.barrier.rawValue
        
        node.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        
        let forceVector = SCNVector3(node.worldFront.x, node.worldFront.y, node.worldFront.z)
        
        node.physicsBody?.applyForce(forceVector, asImpulse: true)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
}





