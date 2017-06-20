//
//  CollisionScene.swift
//  ARKitExamples
//
//  Created by Mohammad Azam on 6/19/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import SceneKit

class CollisionScene : SCNScene, SCNPhysicsContactDelegate {
    
    override init() {
        super.init()
        
        self.physicsWorld.contactDelegate = self
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        // collision between the ball and the barrier
        if contact.nodeA.physicsBody?.categoryBitMask == BodyType.ball.rawValue && contact.nodeB.physicsBody?.categoryBitMask == BodyType.barrier.rawValue {
            
            
        }
        else if contact.nodeA.physicsBody?.categoryBitMask == BodyType.barrier.rawValue && contact.nodeB.physicsBody?.categoryBitMask == BodyType.ball.rawValue  {
            
            /* uncomment the code if you want to see the color changing of the barriers on collision
             
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.random()
            
            contact.nodeA.geometry?.materials = [material]
                 */
    
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
