//
//  MainMenu.swift
//  Upstream
//
//  Created by Wiley Siler on 7/14/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    /* UI Connections */
    
    var playButton: MSButtonNode!
    var earth: SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        playButton = childNode(withName: "playButton") as! MSButtonNode
        playButton.selectedHandler = {
            self.loadGame()
        }
        
        earth = childNode(withName: "earth") as! SKSpriteNode
        let rotate:SKAction! = SKAction.init(named:"EarthScale")
        earth.run(rotate)
        
        
    }
    
    
    func loadGame() {
        /* 1) Grab reference to our SpriteKit view */
        if let view = self.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
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
