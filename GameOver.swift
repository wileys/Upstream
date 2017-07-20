//
//  GameOver.swift
//  Upstream
//
//  Created by Wiley Siler on 7/13/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver: SKScene {
    /* UI Connections */
    
    var restartButton: MSButtonNode!
    var galleryButton: MSButtonNode!
    var earthButton: MSButtonNode!
    
    
    
    override func didMove(to view: SKView) {
        restartButton = childNode(withName: "restartButton") as! MSButtonNode
        galleryButton = childNode(withName: "galleryButton") as! MSButtonNode
        earthButton = childNode(withName: "earthButton") as! MSButtonNode
        
        restartButton.selectedHandler = { [unowned self] in
            self.loadGame()
        }
        
        galleryButton.selectedHandler = { [unowned self] in
            self.loadGallery()
        }
        
        earthButton.selectedHandler = { [unowned self] in
            self.loadEarth()
        }
        
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

    func loadGallery() {
        self.removeAllChildren()

        /* 1) Grab reference to our SpriteKit view */
        if let view = self.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Gallery") {
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

