//
//  ARBarGraph.swift
//  ARGraph
//
//  Created by Mohammad Azam on 6/12/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

struct ARBarGraphItem {
    var label :String
    var height :CGFloat
    var adjustedHeight :CGFloat = 0
    
    init(label :String, height :CGFloat) {
        self.label = label
        self.height = height
    }
    
}

class ARBarGraph : SCNNode {
    
    var items = [ARBarGraphItem]()
    
    init(items :[ARBarGraphItem]) {
        
        super.init()
        self.items = items
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        var x :CGFloat = 0
        var delta :CGFloat = 0
        
        let maxItem = self.items.max { $0.height < $1.height }
        
        for item in self.items {
            
            print(item.height/(maxItem?.height)!)
            
            let box = SCNBox(width: 0.1, height: item.height/(maxItem?.height)!, length: 0.1, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.random()
            box.firstMaterial = material
            
            delta = box.height/2
            
            let boxNode = SCNNode(geometry: box)
            boxNode.position = SCNVector3(0 + x, -1 + delta, -1)
            
            let text = SCNText(string: item.label, extrusionDepth: 5.0)
            text.firstMaterial?.diffuse.contents = UIColor.orange
            text.firstMaterial?.specular.contents = UIColor.orange
            text.font = UIFont(name: "Optima", size: 44)
            text.containerFrame = CGRect(x: 0, y: 0, width: 100, height: 44)
            
            let textNode = SCNNode(geometry: text)
            textNode.position = SCNVector3(0,0,-1) // place it little away from the user
            
            x += 0.12
            
            self.addChildNode(boxNode)
        }
        
    }
    
}

