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
    var heatEvent: SKSpriteNode!
    var heroEvent: SKSpriteNode!
    var droughtEvent: SKSpriteNode!
    var chemicalEvent: SKSpriteNode!
    var weatherEvent: SKSpriteNode!
    var giraffeEvent: SKSpriteNode!
    var spiderEvent: SKSpriteNode!
    var wonEvent: SKSpriteNode!

    var earthButton: MSButtonNode!
    
    
    override func didMove(to view: SKView) {
        
        windEvent = childNode(withName: "windEvent") as! SKSpriteNode
        droughtEvent = childNode(withName: "droughtEvent") as! SKSpriteNode
        weatherEvent = childNode(withName: "weatherEvent") as! SKSpriteNode
        chemicalEvent = childNode(withName: "chemicalEvent") as! SKSpriteNode
        heroEvent = childNode(withName: "heroEvent") as! SKSpriteNode
        heatEvent = childNode(withName: "heatEvent") as! SKSpriteNode
        giraffeEvent = childNode(withName: "giraffeEvent") as! SKSpriteNode
        spiderEvent = childNode(withName: "spiderEvent") as! SKSpriteNode
        wonEvent = childNode(withName: "wonEvent") as! SKSpriteNode
        
        windEvent.isHidden = true
        droughtEvent.isHidden = true
        weatherEvent.isHidden = true
        chemicalEvent.isHidden = true
        heroEvent.isHidden = true
        heatEvent.isHidden = true
        giraffeEvent.isHidden = true
        spiderEvent.isHidden = true
        wonEvent.isHidden = true
        
        if hasDoneWindEvent == true {
            windEvent.isHidden = false
        }
        
        if hasDoneDroughtEvent == true {
            droughtEvent.isHidden = false
        }
        
        if hasDoneWeatherEvent == true {
            weatherEvent.isHidden = false
        }
        
        if hasDoneChemicalEvent == true {
            chemicalEvent.isHidden = false
        }
        
        if hasDoneHeroEvent == true {
            heroEvent.isHidden = false
        }
        
        if hasDoneHeatEvent == true {
            heatEvent.isHidden = false
        }
        
        if hasDoneGiraffeEvent == true {
            giraffeEvent.isHidden = false
        }
        
        if hasDoneSpiderEvent == true {
            spiderEvent.isHidden = false
        }
        
        if hasWonGame == true {
            wonEvent.isHidden = false
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
            
        }
    }
    
}
