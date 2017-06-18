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

class RedCarpetViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    
    var label :UILabel!
    
    var planes = [Plane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.sceneView.frame.size.width, height: 100))
        self.label.center = self.sceneView.center
        self.label.textAlignment = .center
        self.label.text = "0 planes detected"
        
        self.sceneView.addSubview(self.label)
        
       self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        let plane = self.planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
            }.first
        
        if plane == nil {
            return
        }
        
        plane?.update(anchor: anchor as! ARPlaneAnchor)
        
        print("DID UPDATE")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if !(anchor is ARPlaneAnchor) {
            return
        }
        
        print("DID ADD ANCHOR")
        
        
        
        let plane = Plane(anchor: anchor as! ARPlaneAnchor)
        self.planes.append(plane)
        
        DispatchQueue.main.async {
             self.label.text = "\(self.planes.count) planes detected!"
        }
        
        node.addChildNode(plane)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
}


