
//
//  Earth.swift
//  Upstream
//
//  Created by Wiley Siler on 7/11/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

var lionCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "lionCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "lionCount")
    }

}
var giraffeCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "giraffeCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "giraffeCount")
    }

}
var goldenCount: Int  {
    get {
        return UserDefaults.standard.integer(forKey: "goldenCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "goldenCount")
    }

}
var sealCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "sealCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "sealCount")
    }

}


class Earth: SKScene {
    /* UI Connections */
    
    var playButton: MSButtonNode!
    var galleryButton: MSButtonNode!
    
    var bioBar: SKSpriteNode!
    var dayCountLabel: SKLabelNode!
    var populationLabel: SKLabelNode!
   
    /* Animal counters */
    
    
    
    override func didMove(to view: SKView) {
        
        let bioNumber = bioDiversity

        /* Setup your scene here */
        
        bioBar = childNode(withName: "bioBar") as! SKSpriteNode
        
        
        /* Make sure bio bar doesn't display negative */
        if bioDiversity > 0 {
            bioBar.xScale = CGFloat(bioNumber)
        } else {
            bioBar.isHidden = true
        }
        
        /* update the labels */
        dayCountLabel = childNode(withName: "dayCountLabel") as! SKLabelNode
        dayCountLabel.text = String(dayCount)
        
        populationLabel = childNode(withName: "populationLabel") as! SKLabelNode
        populationLabel.text = String(totalSpecimens)
        
        /* Play button set up */
        
        playButton = childNode(withName: "playButton") as! MSButtonNode
        playButton.selectedHandler = {

            self.loadGame()
            
        }

        /* Gallery button set up */
        
        galleryButton = childNode(withName: "galleryButton") as! MSButtonNode
        galleryButton.selectedHandler = {
            self.loadGallery()
        }
        
        
        /* Count the number of each specimen in the array */
        countSpecimens()
        
        
        
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
    
    func loadGallery() {
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
    
//    func resetUserDefaults() {
//        
//        UserDefaults.standard.set(0, forKey: "totalSpecimens")
//        
//        UserDefaults.standard.set(0, forKey: "dayCount")
//        
//        UserDefaults.standard.set(0.4, forKey: "bioDiversity")
//        
//        
//    }
    
    func countSpecimens() {
        for specimen in collectedList {
            switch specimen {
                case "Lion":
                    lionCount += 1
                case "Seal":
                    sealCount += 1
                case "Golden Retriever":
                    goldenCount += 1
                case "Giraffe":
                    giraffeCount += 1
                default:
                    return
            }
        }
    }
    
    
}
