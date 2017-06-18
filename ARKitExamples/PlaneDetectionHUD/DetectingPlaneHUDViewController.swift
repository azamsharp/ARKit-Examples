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

class DetectingPlaneHUDViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
   // private var hud :MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
         self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.automaticallyUpdatesLighting = true
        
        let scene = SCNScene()
        
       // self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
       // self.hud.label.text = "Detecting Plane..."
        
        self.sceneView.scene = scene
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            print("plane anchor is found")
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if !(anchor is ARPlaneAnchor) {
            return
        }
        
        print("new node has been added for the anchor")
        
        
        // hide the hud
//        DispatchQueue.main.async {
//
//            self.hud.mode = .customView
//            let image = UIImage(named: "Checkmark")
//            self.hud.customView = UIImageView(image: image)
//            self.hud.isSquare = true
//            self.hud.label.text = "Plane Detected"
//            self.hud.hide(animated: true, afterDelay: 2.0)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        sceneView.session.delegate = self
        
        // enable horizontal plane detection
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
}


