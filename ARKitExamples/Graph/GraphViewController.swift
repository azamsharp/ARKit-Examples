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

class GraphViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        
        let barGraph = ARBarGraph(items: [ARBarGraphItem(label :"Apple", height:67), ARBarGraphItem(label: "Orange",height:45),ARBarGraphItem(label: "Red",height:100),ARBarGraphItem(label: "Purple",height:98)])
        
        barGraph.position = SCNVector3Make(0.1,0.1,-0.5)
        
        scene.rootNode.addChildNode(barGraph)
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
}


