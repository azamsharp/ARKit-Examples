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

class PlanetsViewController: UIViewController, ARSCNViewDelegate {
    
    let planets = ["earth_texture_map.jpg","mars.jpg", "jupiter.jpg"]
    var i = 0
    
    var sceneView: ARSCNView!
    var label :UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        
        
        let scene = SCNScene()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        sceneView.scene = scene
        
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.sceneView.frame.size.width, height: 100))
        self.label.center = self.sceneView.center
        self.label.textAlignment = .center
        self.label.text = "Tap on the screen"
        
        self.sceneView.addSubview(self.label)
    }
    
    @objc func tapped(recognizer :UIGestureRecognizer) {
        
        self.label.text = ""
        
        if i > self.planets.count - 1 {
            return
        }
        
        guard let currentFrame = self.sceneView.session.currentFrame else {
            return
        }
        
        print(currentFrame.camera.eulerAngles)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.1
        
        let geometry = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: planets[i])
        
        geometry.materials = [material]
        
        let node = SCNNode(geometry: geometry)
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node.physicsBody?.mass = 5
        node.physicsBody?.isAffectedByGravity = false
        
        node.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        
        
        let forceVector = SCNVector3(node.worldFront.x, node.worldFront.y, node.worldFront.z)
        
        print(forceVector)
        
        node.physicsBody?.applyForce(forceVector, asImpulse: true)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
        i += 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
}




