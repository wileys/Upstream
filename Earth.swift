
//
//  Earth.swift
//  Upstream
//
//  Created by Wiley Siler on 7/11/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit


var randomNumber: Int {
    get {
        return UserDefaults.standard.integer(forKey: "randomNumber")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "randomNumber")
    }
    
}


var timesVisited = 0


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
    var chemicalEarth: SKSpriteNode!
    
    var fire: SKNode!
    var wind: SKNode!
    
    
    override func didMove(to view: SKView) {
        print(bioDiversity)
        
        timesVisited += 1
        
       /* load the earth graphic and animate it to pulse ! */
        earth = childNode(withName: "earthGraphic") as! SKSpriteNode
        let pulse:SKAction = SKAction.init(named:"EarthScale")!
        earth.run(pulse)
        
        chemicalEarth = childNode(withName: "chemicalEarth") as! SKSpriteNode
        chemicalEarth.isHidden = true
        
        fire = childNode(withName: "fire")
        fire.isHidden = true
        
        wind = childNode(withName: "wind")
        wind.isHidden = true
        
        /* default event */
        eventName = "none"
        
        
        /* set up stats layer to move all stats at once */
        stats = childNode(withName: "stats") as! SKSpriteNode
    
        
        eventSprite = childNode(withName: "eventSprite") as! SKSpriteNode

        
        //countSpecimens()
        collectedList.removeAll()
        
        if timesVisited == 1 {
            checkForEvent()
        }
        
        if bioDiversity > 1.0 {
            bioDiversity = 1.0
        }
        
        checkForEventSecond()

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
        } else if bioNumber > 1.0 {
            previousBioNumber = 1
        } else {
            previousBioNumber = bioDiversity

        }
        
        /* Play button set up */
        
        playButton = childNode(withName: "playButton") as! MSButtonNode
        playButton.selectedHandler = {
            self.resetUserDefaults()
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
    
    
    
    
    /* Checks to see if there's a possible event */
    
    func checkForEvent() {
        /* Sets an ORIGINAL event */
        
        /* Overflood of giraffes? Taken care of. */
        if giraffeCount > 10 {
            UserDefaults.standard.set("giraffe event", forKey: "eventName")
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "giraffesevent"))
            bioDiversity -= 0.1
            giraffeCount = 0
            totalSpecimens -= giraffeCount
        } else if spiderCount > 10 {
            UserDefaults.standard.set("spider event", forKey: "eventName")
            bioDiversity += 0.1
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "spiderevent"))
            spiderCount = 1
        
        } else if bioDiversity > 0.3 {
            if bioDiversity > 0.5 {
                randomNumber = Int(arc4random_uniform(100))
                if randomNumber >= 50 {
                    
                    /* Fifty percent chance it goes here */
                    if randomNumber > 60 {
                        /* twenty percent chance (of the fifty percent) - CHEMICAL FLOOD */
                        if randomNumber > 80 {
                            playChemicalEvent()
                        } else if randomNumber < 80 {
                            /* twenty percent chance (of the fifty percent) - HEAT WAVE */
                            playHeatEvent()
                        }
                    } else {
                        /* ten percent chance of fifty */
                        playHeroEvent()
                    }
                /* forty percent chance nothing happens */
                } else {
                    setEventToNone()
                }
            } else { /* if biodiversity is between 0.3 and 0.5 */
                randomNumber = Int(arc4random_uniform(100))
                
                if randomNumber >= 60 {
                    if randomNumber >= 80 {
                        playWindEvent()
                    }
                 else if randomNumber < 80 {
                        playDroughtEvent()
                 }
                    
                }
            }
        
        } else {
            setEventToNone()
        }
        print(eventName)
    }
    
    /* checks for the event that has already been chosen - this is so that it won't disappear if you 
     look @ the gallery and then come back */
    
    func checkForEventSecond() {
        switch eventName {
        case "heat event":
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "heatevent"))
            fire.isHidden = false
        case "chemical event":
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "chemicalevent"))
            chemicalEarth.isHidden = false
        case "hero event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "superheroesevent"))
        case "none": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent"))
        case "giraffe event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "giraffesevent"))
        case "spider event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "spiderevent"))
        case "wind event":
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "windevent"))
            wind.isHidden = false
        case "drought event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "droughtevent"))
        default: return
        }
    }
    
    func playChemicalEvent() {
        if hasDoneChemicalEvent == false {
            UserDefaults.standard.set("chemical event", forKey: "eventName")
            hasDoneChemicalEvent = true
            bioDiversity = 0.3
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "chemicalevent"))
            chemicalEarth.isHidden = false
        }
    }
    
    func playHeatEvent() {
        if hasDoneHeatEvent == false {
            hasDoneHeatEvent = true
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "heatevent"))
            bioDiversity -= 0.2
            fire.isHidden = false
            UserDefaults.standard.set("heat event", forKey: "eventName")
        }
    }
    
    func playHeroEvent() {
        if hasDoneHeroEvent == false {
            hasDoneHeroEvent = true
            UserDefaults.standard.set("hero event", forKey: "eventName")
            bioDiversity += 0.2
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "superheroesevent"))
        }
    }
    
    func playWindEvent() {
        if hasDoneWindEvent == false {
            hasDoneWindEvent = true
            wind.isHidden = false
            UserDefaults.standard.set("wind event", forKey: "eventName")
            bioDiversity -= 0.05
            eventSprite.texture = SKTexture(image:#imageLiteral(resourceName: "windevent"))
        }
    }
    
    func playDroughtEvent() {
        if hasDoneDroughtEvent == false {
            hasDoneDroughtEvent = true
            UserDefaults.standard.set("drought event", forKey: "eventName")
            bioDiversity -= 0.1
            eventSprite.texture = SKTexture(image:#imageLiteral(resourceName: "droughtevent"))
        }
    }

    
    func setEventToNone() {
        UserDefaults.standard.set("none", forKey: "eventName")
        eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent"))
    }
    
    func setUserDefaults() {
        UserDefaults.standard.set(previousBioNumber, forKey: "previousBioNumber")
        UserDefaults.standard.set(randomNumber, forKey:"randomNumber")
        //UserDefaults.standard.set(eventName, forKey: "eventName")
        print(eventName)

    }
    
    
    
    func resetUserDefaults() {
        UserDefaults.standard.set(0, forKey:"randomNumber")

    }
    
}
