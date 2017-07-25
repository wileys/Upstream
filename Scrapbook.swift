//
//  Scrapbook.swift
//  Upstream
//
//  Created by Wiley Siler on 7/25/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit



class Scrapbook: SKScene {
    
    var windEvent: SKSpriteNode!
    var earthButton: MSButtonNode!
    
    
    override func didMove(to view: SKView) {
        
        windEvent = childNode(withName: "windEvent") as! SKSpriteNode
        
        windEvent.isHidden = true
        
        if hasDoneWindEvent == true {
            windEvent.isHidden = false
        }
        
        earthButton = childNode(withName: "earthButton") as! MSButtonNode
        
        earthButton.selectedHandler = { [unowned self] in
            self.loadEarth()
        }
        
    }
    
    func loadEarth() {
        self.removeAllChildren()
        
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
