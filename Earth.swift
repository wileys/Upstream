
//
//  Earth.swift
//  Upstream
//
//  Created by Wiley Siler on 7/11/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

var previousBioNumber = 0.4
var chemicalEvent = false

class Earth: SKScene {
    /* UI Connections */
    
    var playButton: MSButtonNode!
    var galleryButton: MSButtonNode!
    
    var bioBar: SKSpriteNode!
    var dayCountLabel: SKLabelNode!
    var populationLabel: SKLabelNode!
    var eventSprite: SKSpriteNode!
    
    
    
    
    
    override func didMove(to view: SKView) {
        
    
        eventName = "none"
        
        if bioDiversity > 0.5 {
            
            eventName = "chemical event"
            print(eventName)
        }
        
        eventSprite = childNode(withName: "eventSprite") as! SKSpriteNode

        
        countSpecimens()
        collectedList.removeAll()
        
        checkForEvent()


        /* calling down the biodiversity nubmer */
        let bioNumber = bioDiversity
        
       
        bioBar = childNode(withName: "bioBar") as! SKSpriteNode
        bioBar.xScale = CGFloat(previousBioNumber)
        
        /* Make sure bio bar doesn't display negative */
        if bioDiversity > 0 {
            let scaleBioBar:SKAction = SKAction.scaleX(to: CGFloat(bioNumber), duration: 1)
            let wait:SKAction = SKAction.wait(forDuration: 2)
            let sequence = SKAction.sequence([scaleBioBar, wait])
            bioBar.run(sequence)
            
            
        } else {
            bioBar.isHidden = true
        }
        
        /* update the labels */
        dayCountLabel = childNode(withName: "dayCountLabel") as! SKLabelNode
        dayCountLabel.text = String(dayCount)
        
        populationLabel = childNode(withName: "populationLabel") as! SKLabelNode
        populationLabel.text = String(totalSpecimens)
        
        if bioNumber < 0.01 {
            previousBioNumber = 0
        } else {
            previousBioNumber = bioDiversity

        }
        
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
    
    
    /* Animal counters */
    
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
                case "Chicken":
                    chickenCount += 1
                case "Spider":
                    spiderCount += 1
                case "Caterpillar":
                    caterpillarCount += 1
                case "Penguin":
                    penguinCount += 1
                case "Monkey":
                    monkeyCount += 1
                case "Eagle":
                    eagleCount += 1
                case "Panda":
                    pandaCount += 1
                default:
                    return
            }
        }
    }
    
    /* Checks to see if there's a possible event */
    
    func checkForEvent() {
        /* Overflood of giraffes? Taken care of. */
        if giraffeCount > 10 {
            eventName = "giraffeEvent"
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "giraffesevent"))
            bioDiversity -= 0.1
            giraffeCount = 0
            totalSpecimens -= giraffeCount
        } else if spiderCount > 10 {
            eventName = "spiderEvent"
            bioDiversity += 0.2
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "spiderevent"))
        
        } else if bioDiversity > 0.5 {
            let randomNumber = arc4random_uniform(100)
            if randomNumber >= 50 {
                chemicalEvent = true
                print("Chemical event playing")
                bioDiversity = 0.3
                eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "chemicalevent"))
            } else {
                eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent"))
            }
        } else {
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent"))
        }
        
    }
    
    
}
