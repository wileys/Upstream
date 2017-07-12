//
//  Gallery.swift
//  Upstream
//
//  Created by Wiley Siler on 7/12/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit



class Gallery: SKScene {
    /* UI Connections */
    
    var goldenCountLabel: SKLabelNode!
    var sealCountLabel: SKLabelNode!
    var giraffeCountLabel: SKLabelNode!
    var lionCountLabel: SKLabelNode!
    
    
    
    
    override func didMove(to view: SKView) {
        goldenCountLabel = childNode(withName: "goldenCountLabel") as! SKLabelNode
        lionCountLabel = childNode(withName: "lionCountLabel") as! SKLabelNode
        sealCountLabel = childNode(withName: "sealCountLabel") as! SKLabelNode
        giraffeCountLabel = childNode(withName: "giraffeCountLabel") as! SKLabelNode
        
        goldenCountLabel.text = String(goldenCount)
        lionCountLabel.text = String(lionCount)
        sealCountLabel.text = String(sealCount)
        giraffeCountLabel.text = String(giraffeCount)
        
    }
    
    func loadEarth() {
        /* 1) Grab reference to our SpriteKit view */
        if let view = self.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Earth") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    
}
