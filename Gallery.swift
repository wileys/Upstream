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
    var chickenCountLabel: SKLabelNode!
    var spiderCountLabel: SKLabelNode!
    var caterpillarCountLabel: SKLabelNode!
    var penguinCountLabel: SKLabelNode!
    var monkeyCountLabel: SKLabelNode!
    var eagleCountLabel: SKLabelNode!
    var pandaCountLabel: SKLabelNode!
    var foxCountLabel: SKLabelNode!
    var butterflyCountLabel: SKLabelNode!
    var snakeCountLabel: SKLabelNode!
    var sharkCountLabel: SKLabelNode!
    var rabbitCountLabel: SKLabelNode!
    var octopusCountLabel: SKLabelNode!
    var cowCountLabel: SKLabelNode!
    
    var playButton: MSButtonNode!
    var earthButton: MSButtonNode!
    
    
    override func didMove(to view: SKView) {
        goldenCountLabel = childNode(withName: "goldenCountLabel") as! SKLabelNode
        lionCountLabel = childNode(withName: "lionCountLabel") as! SKLabelNode
        sealCountLabel = childNode(withName: "sealCountLabel") as! SKLabelNode
        giraffeCountLabel = childNode(withName: "giraffeCountLabel") as! SKLabelNode
        chickenCountLabel = childNode(withName: "chickenCountLabel") as! SKLabelNode
        spiderCountLabel = childNode(withName: "spiderCountLabel") as! SKLabelNode
        caterpillarCountLabel = childNode(withName: "caterpillarCountLabel") as! SKLabelNode
        penguinCountLabel = childNode(withName: "penguinCountLabel") as! SKLabelNode
        monkeyCountLabel = childNode(withName: "monkeyCountLabel") as! SKLabelNode
        eagleCountLabel = childNode(withName: "eagleCountLabel") as! SKLabelNode
        pandaCountLabel = childNode(withName: "pandaCountLabel") as! SKLabelNode
        foxCountLabel = childNode(withName: "foxCountLabel") as! SKLabelNode
        butterflyCountLabel = childNode(withName: "butterflyCountLabel") as! SKLabelNode
        snakeCountLabel = childNode(withName: "snakeCountLabel") as! SKLabelNode
        sharkCountLabel = childNode(withName: "sharkCountLabel") as! SKLabelNode
        rabbitCountLabel = childNode(withName: "rabbitCountLabel") as! SKLabelNode
        octopusCountLabel = childNode(withName: "octopusCountLabel") as! SKLabelNode
        cowCountLabel = childNode(withName: "cowCountLabel") as! SKLabelNode

        
        playButton = childNode(withName: "playButton") as! MSButtonNode
        earthButton = childNode(withName: "earthButton") as! MSButtonNode
        
        playButton.selectedHandler = {
            self.loadGame()
        }
        
        earthButton.selectedHandler = {
            self.loadEarth()
        }
        
        goldenCountLabel.text = String(goldenCount)
        lionCountLabel.text = String(lionCount)
        sealCountLabel.text = String(sealCount)
        giraffeCountLabel.text = String(giraffeCount)
        chickenCountLabel.text = String(chickenCount)
        spiderCountLabel.text = String(spiderCount)
        caterpillarCountLabel.text = String(caterpillarCount)
        penguinCountLabel.text = String(penguinCount)
        monkeyCountLabel.text = String(monkeyCount)
        eagleCountLabel.text = String(eagleCount)
        pandaCountLabel.text = String(pandaCount)
        foxCountLabel.text = String(foxCount)
        butterflyCountLabel.text = String(pandaCount)
        snakeCountLabel.text = String(snakeCount)
        sharkCountLabel.text = String(sharkCount)
        rabbitCountLabel.text = String(rabbitCount)
        octopusCountLabel.text = String(octopusCount)
        cowCountLabel.text = String(cowCount)
        
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
