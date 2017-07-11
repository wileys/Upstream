
//
//  Earth.swift
//  Upstream
//
//  Created by Wiley Siler on 7/11/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit



class Earth: SKScene {
    /* UI Connections */
    
    var playButton: MSButtonNode!
    var bioBar: SKSpriteNode!
    var dayCountLabel: SKLabelNode!
    var populationLabel: SKLabelNode!
   
    
    
    override func didMove(to view: SKView) {
        
        let bioNumber = bioDiversity

        /* Setup your scene here */
        
        bioBar = childNode(withName: "bioBar") as! SKSpriteNode
        
        
        
        if bioDiversity > 0 {
            bioBar.xScale = CGFloat(bioNumber)
        } else {
            bioBar.isHidden = true
        }
        
        dayCountLabel = childNode(withName: "dayCountLabel") as! SKLabelNode
        dayCountLabel.text = String(dayCount)
        
        populationLabel = childNode(withName: "populationLabel") as! SKLabelNode
        populationLabel.text = String(totalSpecimens)
        
        playButton = childNode(withName: "playButton") as! MSButtonNode
        print(bioDiversity)
        playButton.selectedHandler = {

            self.loadGame()
            
        }
        print(dayCount)
        
        
        
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
    
    func resetUserDefaults() {
        
        UserDefaults.standard.set(0, forKey: "totalSpecimens")
        
        UserDefaults.standard.set(0, forKey: "dayCount")
        
        UserDefaults.standard.set(0.4, forKey: "bioDiversity")
        
        
    }
    
    
}
