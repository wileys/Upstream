
//
//  Earth.swift
//  Upstream
//
//  Created by Wiley Siler on 7/11/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit


var chemicalEvent = false

class Earth: SKScene {
    /* UI Connections */
    
    var playButton: MSButtonNode!
    var galleryButton: MSButtonNode!
    
    var bioBar: SKSpriteNode!
    var dayCountLabel: SKLabelNode!
    var populationLabel: SKLabelNode!
    var eventSprite: SKSpriteNode!
    var stats: SKSpriteNode!
    
    var earth: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        
       /* load the earth graphic and animate it to pulse ! */
        earth = childNode(withName: "earthGraphic") as! SKSpriteNode
        let pulse:SKAction = SKAction.init(named:"EarthScale")!
        earth.run(pulse)
        
        
        /* default event */
        eventName = "none"
        
        /* set up stats layer to move all stats at once */
        stats = childNode(withName: "stats") as! SKSpriteNode
        
        /* this doesn't work yet rip */
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
        dayCountLabel = stats.childNode(withName: "dayCountLabel") as! SKLabelNode
        dayCountLabel.text = String(dayCount)
        
        populationLabel = stats.childNode(withName: "populationLabel") as! SKLabelNode
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
        
        setUserDefaults()
        
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
            bioDiversity += 0.1
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "spiderevent"))
            spiderCount = 1
        
        } else if bioDiversity > 0.5 {
            let randomNumber = arc4random_uniform(100)
            if randomNumber >= 50 {
                /* Fifty percent chance it goes here */
                if randomNumber > 60 {
                    /* twenty percent chance (of the fifty percent) */
                    if randomNumber > 80 {
                        chemicalEvent = true
                        print("Chemical event playing")
                        bioDiversity = 0.3
                        eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "chemicalevent"))
                    } else if randomNumber < 80 {
                        /* twenty percent chance (of the fifty percent) */
                        print("Heat event playing")
                        eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "heatevent"))
                        bioDiversity -= 0.2
                    }
                } else {
                    /* ten percent chance of fifty */
                    bioDiversity += 0.2
                    print("Hero event playing")
                    eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "superheroesevent"))
                }
            /* forty percent chance nothing happens */
            } else {
                eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent"))
            }
        } else {
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent"))
        }
        
    }
    
    func setUserDefaults() {
        UserDefaults.standard.set(previousBioNumber, forKey: "previousBioNumber")
    }
    
}
