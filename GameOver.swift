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
    
    var funFact: SKSpriteNode!
    
    var factAsset: String!
    
    let factList = ["factco2", "factpalmoil", "factconsumerpower", "factenergy", "factcattle", "factrain", "factwaste"]
    
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
        
        let totalIndex = factList.count - 1
        
        factAsset = factList[Int(randomBetweenNumbers(firstNum: 0, secondNum: CGFloat(totalIndex)))]
        print(factAsset)
        
        funFact = childNode(withName: "funFact") as! SKSpriteNode
        funFact.texture = SKTexture.init(imageNamed: factAsset)
        
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
            
        }
    }
    
    
}

