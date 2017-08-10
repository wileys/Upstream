
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
    var spiderEmitter: SKNode!
    
    var alertBox: SKSpriteNode!
    /* Yes & no buttons */
    var yesButton: MSButtonNode!
    var noButton: MSButtonNode!
    var alertMessage: SKSpriteNode!
    
    var background: SKSpriteNode!
    
    var scrapbookButton: MSButtonNode!
    
    /* if the user won game - variables */
    var continueButton: MSButtonNode!
    var wonBox: SKSpriteNode!
    
    var restartButton: MSButtonNode!
    
    override func didMove(to view: SKView) {
        
        timesVisited += 1
        
        background = childNode(withName: "background") as! SKSpriteNode
                
       /* load the earth graphic and animate it to pulse ! */
        earth = childNode(withName: "earthGraphic") as! SKSpriteNode
        let pulse:SKAction = SKAction.init(named:"EarthScale")!
        earth.run(pulse)
        
        chemicalEarth = childNode(withName: "chemicalEarth") as! SKSpriteNode
        chemicalEarth.isHidden = true
        
        fire = earth.childNode(withName: "fire")
        fire.isHidden = true
        
        wind = earth.childNode(withName: "wind")
        wind.isHidden = true
        
        spiderEmitter = earth.childNode(withName: "spiderEmitter")
        spiderEmitter.isHidden = true
        
        /* default event */
        eventName = "none"
        
        
        /* set up stats layer to move all stats at once */
        stats = childNode(withName: "stats") as! SKSpriteNode
    
        
        eventSprite = childNode(withName: "eventSprite") as! SKSpriteNode
        
        
        
        /* Alert box set up */
        alertBox = childNode(withName: "alertBox") as! SKSpriteNode
        alertBox.isHidden = true
        alertMessage = alertBox.childNode(withName: "alertMessage") as! SKSpriteNode
        yesButton = alertBox.childNode(withName: "yesButton") as! MSButtonNode
        noButton = alertBox.childNode(withName: "noButton") as! MSButtonNode
        
        /* sets up the restart button */
        restartButton = childNode(withName: "restartButton") as! MSButtonNode
        restartButton.selectedHandler = {
            self.alertMessage.texture = SKTexture(image: #imageLiteral(resourceName: "newgamequestion"))
            self.alertBox.isHidden = false
            self.background.zPosition = 5
            
            self.yesButton.selectedHandler = { [unowned self] in
                self.restartGame()
            }
            
            self.noButton.selectedHandler = {
                self.alertBox.isHidden = true
                self.background.zPosition = -2
            }
        }
        
        scrapbookButton = childNode(withName: "scrapbookButton") as! MSButtonNode
        scrapbookButton.selectedHandler = { [unowned self] in
            self.removeAllChildren()
            self.removeAllActions()
            self.loadScrapbook()
            
        }
        
        
        /* set up congratulatory message */
        
        wonBox = childNode(withName: "wonBox") as! SKSpriteNode
        continueButton = wonBox.childNode(withName: "continueButton") as! MSButtonNode
        wonBox.isHidden = true
        
        continueButton.selectedHandler = {
            self.wonBox.isHidden = true
        }

        
        collectedList.removeAll()
        
        if timesVisited == 1 {
            checkForEvent()
        }
        
  
        if bioDiversity > 1.0 {
            bioDiversity = 1.0
        } else if bioDiversity < 0.01 {
            bioDiversity = 0
        }
    
        
        checkForEventSecond()
        
        /* set death event */
       
        
        if Double(bioDiversity) < 0.01 {
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "failureevent"))
            eventName = "over"
            UserDefaults.standard.set("over", forKey: "eventName")

            print(eventName)
            
            
        }

        /* calling down the biodiversity nubmer */
        let bioNumber = bioDiversity
        
        /* Bio bar scale action */
        
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
        
        /* round down bio number */
        
        if bioNumber < 0.01 {
            previousBioNumber = 0
        } else if bioNumber > 1.0 {
            previousBioNumber = 1
        } else {
            previousBioNumber = bioDiversity

        }
        
        
       
        /* Play button set up */
        
        playButton = childNode(withName: "playButton") as! MSButtonNode
        playButton.selectedHandler = { [unowned self] in
            self.removeAllChildren()
            self.removeAllActions()
            self.resetUserDefaults()
            self.loadGame()
        }

        /* Gallery button set up */
        
        galleryButton = childNode(withName: "galleryButton") as! MSButtonNode
        galleryButton.selectedHandler = { [unowned self] in
            previousBioNumber = bioDiversity
            self.removeAllChildren()
            self.removeAllActions()
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
            
            
        }
    }
    
    func loadScrapbook() {
        /* 1) Grab reference to our SpriteKit view */
        if let view = self.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Scrapbook") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
        }
    }
    
    
    
    
    /* Checks to see if there's a possible event */
    
    func checkForEvent() {
        /* Sets an ORIGINAL event */
        if bioDiversity >= 1 && hasWonGame == false {
            print("sdfsdf")
            wonBox.isHidden = false
            UserDefaults.standard.set(true, forKey: "hasWonGame")
            setEventToNone()
            
        } else if hasDoneTutorialEvent == false {
            /* play the tutorial event ! */
            alertMessage.texture = SKTexture(image: #imageLiteral(resourceName: "tutorialquestion"))
            alertBox.isHidden = false
            background.zPosition = 5
            
            /* Button actions */
            
            yesButton.selectedHandler = {
                UserDefaults.standard.set("tutorial event", forKey: "eventName")
                self.eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "tutorialeventnonetheless"))
                self.alertButtonClicked()
                
                
            }
            
            noButton.selectedHandler = {
                UserDefaults.standard.set("tutorial event", forKey: "eventName")
                self.eventSprite.texture = SKTexture(image:#imageLiteral(resourceName: "tutorialevent"))
                self.alertButtonClicked()
                
            }

            hasDoneTutorialEvent = true
            return

            
        } else if giraffeCount > 10 {
            /* Overflood of giraffes? Taken care of. */

            UserDefaults.standard.set("giraffe event", forKey: "eventName")
            hasDoneGiraffeEvent = true
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "giraffeevent2"))
            bioDiversity -= 0.1
            giraffeCount = 0
            totalSpecimens -= giraffeCount
        } else if spiderCount > 10 {
            UserDefaults.standard.set("spider event", forKey: "eventName")
            bioDiversity += 0.1
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "spiderevent2"))
            spiderEmitter.isHidden = false
            spiderCount = 1
            hasDoneSpiderEvent = true
        
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
                        if randomNumber <= 70 {
                            playDroughtEvent()

                        } else if randomNumber > 70 {
                            setEventToNone()
                        }
                    }
            }
            }
        
        } else {
            setEventToNone()
        }
        
    }
    
    /* checks for the event that has already been chosen - this is so that it won't disappear if you 
     look @ the gallery and then come back */
    
    func checkForEventSecond() {
        switch eventName {
        case "heat event":
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "heatevent2"))
            fire.isHidden = false
        case "chemical event":
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "chemicalevent2"))
            chemicalEarth.isHidden = false
        case "hero event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "superheroesevent2"))
        case "none": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent2"))
        case "giraffe event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "giraffeevent2"))
        case "spider event":
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "spiderevent2"))
            spiderEmitter.isHidden = false
        case "wind event":
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "windevent2"))
            wind.isHidden = false
        case "drought event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "droughtevent2"))
        case "weather event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "weatherevent2"))
        case "tutorial event": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "tutorialevent"))
        case "over": eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "failureevent"))
        default: break
        }
        
    }
    
    
    func playChemicalEvent() {
        if hasDoneChemicalEvent == false {
            /* pop up box sent */
            alertMessage.texture = SKTexture(image: #imageLiteral(resourceName: "zombiequestion2"))
            alertBox.isHidden = false
            background.zPosition = 5
        
            /* Button actions */
            
            yesButton.selectedHandler = {
                UserDefaults.standard.set("chemical event", forKey: "eventName")
                hasDoneChemicalEvent = true
                bioDiversity = 0.5
                self.eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "chemicalevent2"))
                self.chemicalEarth.isHidden = false
                let pulse:SKAction = SKAction.init(named:"EarthScale")!
                self.chemicalEarth.run(pulse)

                self.alertButtonClicked()
        
                
            }
            
            noButton.selectedHandler = { [unowned self] in
                bioDiversity = 0
                self.removeAllActions()
                self.removeAllChildren()
                if let view = self.view {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameOver") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        view.presentScene(scene)
                    }
                    
                    view.ignoresSiblingOrder = true
                    
                }

                
            }
        } else {
            checkForEvent()
            
        }
    }
    
    /*Plays the heat event */
    
    func playHeatEvent() {
        if hasDoneHeatEvent == false {
            hasDoneHeatEvent = true
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "heatevent2"))
            bioDiversity -= 0.2
            fire.isHidden = false
            UserDefaults.standard.set("heat event", forKey: "eventName")
        } else {
            checkForEvent()
            
        }
    }
    
    func playHeroEvent() {
        /* Make sure the buttons are untoucheable */
        
        if hasDoneHeroEvent == false {
            alertMessage.texture = SKTexture.init(image: #imageLiteral(resourceName: "aliensquestion2"))
            alertBox.isHidden = false
            background.zPosition = 5
            noButton.selectedHandler = {
                /* show the event! */
                self.eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "superheroesevent2"))
                hasDoneHeroEvent = true
                UserDefaults.standard.set("hero event", forKey: "eventName")
                bioDiversity += 0.2
                self.alertButtonClicked()
                
            }
            
            yesButton.selectedHandler = {
                /* don't show the event */
                self.alertButtonClicked()
                return

            }
        } else {
            checkForEvent()
            
        }
    }
    
    
    /* Plays the wind event - only once */
    func playWindEvent() {
        if hasDoneWindEvent == false {
            hasDoneWindEvent = true
            wind.isHidden = false
            UserDefaults.standard.set("wind event", forKey: "eventName")
            bioDiversity -= 0.05
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "windevent2"))
        }
    }
    
    /* Plays the drought event - only once */
    func playDroughtEvent() {
        if hasDoneDroughtEvent == false {
            hasDoneDroughtEvent = true
            UserDefaults.standard.set("drought event", forKey: "eventName")
            bioDiversity -= 0.1
            eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "droughtevent2"))
        }
    }

    /* Plays the weather event */
    func playWeatherEvent() {
    
        if hasDoneWeatherEvent == false {
            alertMessage.texture = SKTexture.init(image: #imageLiteral(resourceName: "weatherquestion2"))
            alertBox.isHidden = false
            background.zPosition = 5
            noButton.selectedHandler = {
                /* show the event! */
                hasDoneWeatherEvent = true
                UserDefaults.standard.set("weather event", forKey: "eventName")
                bioDiversity -= 0.2
                self.eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "weatherevent2"))
                self.alertButtonClicked()
            }
            
            yesButton.selectedHandler = {
                /* show the event but without a decrease in biodiversity */
                hasDoneWeatherEvent = true
                UserDefaults.standard.set("weather event", forKey: "eventName")
                self.eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "weatherevent2"))
                self.alertButtonClicked()
                return
                
            }

           
        }
    }

    /*Defaults back to no event */
    func setEventToNone() {
        UserDefaults.standard.set("none", forKey: "eventName")
        eventSprite.texture = SKTexture(image: #imageLiteral(resourceName: "noneevent2"))
    }
    
    func setUserDefaults() {
        UserDefaults.standard.set(previousBioNumber, forKey: "previousBioNumber")
        UserDefaults.standard.set(randomNumber, forKey:"randomNumber")
        

    }
    
    
    /* resets the defaults - defaults the random event number */
    func resetUserDefaults() {
        previousBioNumber = bioDiversity
        UserDefaults.standard.set(previousBioNumber, forKey: "previousBioNumber")
        UserDefaults.standard.set(0, forKey:"randomNumber")

    }
    
    /* this is the general thing to do when an alert message button is pressed */
    func alertButtonClicked() {
        self.alertBox.isHidden = true
        self.bioBar.xScale = CGFloat(previousBioNumber)
        if bioDiversity >= 1 {
            bioDiversity = 1
        }
        let scaleBioBar:SKAction = SKAction.scaleX(to: CGFloat(bioDiversity), duration: 1)
        let wait:SKAction = SKAction.wait(forDuration: 2)
        let sequence = SKAction.sequence([scaleBioBar, wait])
                self.bioBar.run(sequence)
        self.background.zPosition = 0
    }
    
    func restartGame() {
        bioDiversity = 0
        self.removeAllActions()
        self.removeAllChildren()
        if let view = self.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
        }
    }
    
}
