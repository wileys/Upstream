//
//  GameScene.swift
//  Upstream
//
//  Created by Wiley Siler on 6/26/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//
import SpriteKit
import GameplayKit
import Foundation
import CoreMotion


enum GameState {
    case playing, gameOver
}




var collectedList = [String]()
let specimensList = ["Lion", "Giraffe", "Golden Retriever", "Seal", "Chicken", "Spider", "Caterpillar", "Penguin", "Monkey", "Eagle", "Panda", "Fox", "Butterfly", "Snake", "Shark", "Rabbit", "Octopus", "Cow"]


var width: CGFloat = 0
var height: CGFloat = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background: SKSpriteNode!
    
    var character: Character!
    var specimenCount: Int = 0
    var force: CGFloat = 1400
    var scrollLayer: SKNode!
    var scrollSpeed: CGFloat = 240
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    var sourceObstacle: SKNode!
    var sourceChemicalObstacle: SKNode!
    var sourceYellowObstacle: SKNode!
    var sourceRedObstacle: SKNode!
    var sourceHeatObstacle: SKNode!
    var obstacleLayer: SKNode!
    var bonusLayer: SKNode!
    var obstacleTimer: CFTimeInterval = 3
    var bonusTimer: CFTimeInterval = 3
    var logTimer: CFTimeInterval = 3
    var logLayer: SKNode!
    var sourceLog: SKNode!
    var specimenCounter: SKLabelNode!
    var logSpeed = CGFloat.random(min: 3.5, max: 4)
    var gameOverMenu: SKSpriteNode!
    var totalSpecimensLabel: SKLabelNode!
    var earthButton: MSButtonNode!
    var gameState: GameState = .playing
    
    var smoke: SKSpriteNode!
    var magicEmitter: SKEmitterNode!

    
    var toBeRemoved = [Bonus]()
    var countUpdated = false
    
    var collectedLabel: SKLabelNode!
    
    
    var specimenName = ""


    
    var maximumWidth = 700
    var minimumWidth = 55

    
    /* Tutorial thumbs */
    var tutorialLabel: SKLabelNode!
   
    
    
    override func didMove(to view: SKView) {
        
        background = childNode(withName: "background") as! SKSpriteNode
        
        if bioDiversity <= 0.01 {
            resetUserDefaults()
        }
        
        timesVisited = 0
       
        bioDiversity -= 0.10
        gameState = .playing
    
    
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        character = childNode(withName: "character") as! Character
        scrollLayer = self.childNode(withName: "scrollLayer")
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        sourceObstacle = self.childNode(withName: "obstacle")
        sourceChemicalObstacle = self.childNode(withName: "sourceChemicalObstacle")
        sourceYellowObstacle = self.childNode(withName: "sourceYellowObstacle")
        sourceRedObstacle = self.childNode(withName: "sourceRedObstacle")
        sourceHeatObstacle = self.childNode(withName: "sourceHeatObstacle")
        bonusLayer = self.childNode(withName: "bonusLayer")
        logLayer = self.childNode(withName: "logLayer")
        sourceLog = self.childNode(withName:"log")
        specimenCounter = childNode(withName: "specimenCounter") as! SKLabelNode
        gameOverMenu = childNode(withName: "gameOverMenu") as! SKSpriteNode
        totalSpecimensLabel = gameOverMenu.childNode(withName: "totalSpecimensLabel") as! SKLabelNode
        earthButton = gameOverMenu.childNode(withName: "earthButton") as! MSButtonNode
        
        tutorialLabel = childNode(withName: "tutorialLabel") as! SKLabelNode
        collectedLabel = childNode(withName: "collectedLabel") as! SKLabelNode
        
        magicEmitter = childNode(withName: "magicEmitter") as! SKEmitterNode
        magicEmitter.isHidden = true
        
        smoke = scrollLayer.childNode(withName: "smoke") as! SKSpriteNode
        smoke.isHidden = true
        
        character.texture = SKTexture(image:#imageLiteral(resourceName: "character"))
        
        if eventName == "chemical event" {
            for background in scrollLayer.children as! [SKSpriteNode] {
                    background.texture = SKTexture(image: #imageLiteral(resourceName: "background orange"))
            }
            
            background.color = UIColor(red:0.61, green:0.47, blue:0.32, alpha:1.0)

        } else if eventName == "heat event" {
            smoke.isHidden = false
        } else if eventName == "hero event" {
            character.texture = SKTexture(image: #imageLiteral(resourceName: "superhero"))
        }

        /* no animals being collected at first */
        collectedLabel.alpha = 0.0
        
        
        /* Show tutorial ? */
        
        if dayCount == 0 {
            tutorialLabel.isHidden = false
        } else {
            tutorialLabel.isHidden = true
        }
        
        //        /* Set up accelerometer */
        //        motionManager.startAccelerometerUpdates()
        //        motionManager.accelerometerUpdateInterval = 0.1
        //        character.physicsBody!.linearDamping = 0
        
        character.isUserInteractionEnabled = true
        
        height = self.size.height
        width = self.size.width
        
        earthButton.selectedHandler = { [unowned self] in
            self.removeAllActions()
            self.removeAllChildren()
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        
        /* Get touch position in scene */
        let location = touch.location(in:self)
        
        switch gameState {
        case .gameOver:
            return
        case .playing:
            if location.x > width/2 {
                //                character.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                character.physicsBody?.applyImpulse(CGVector(dx:200, dy:0))
                
                
            } else if location.x < width/2 {
                //                character.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                character.physicsBody?.applyImpulse(CGVector(dx:-200, dy:0))
                
            }
            
            
        }
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        scrollWorld()
        if scrollSpeed > 0 {
            scrollObstacles()
            scrollBonus()
            scrollLogs()
        }
        
        for bonus in toBeRemoved {
            bonus.removeFromParent()
            countUpdated = false
        }
        
        toBeRemoved = [Bonus]()
        
        /* timers count */
        obstacleTimer += fixedDelta
        bonusTimer += fixedDelta
        logTimer += fixedDelta
        
        specimenCounter.text = "\(specimenCount)"
        
    }
    
    func didBegin (_ contact: SKPhysicsContact) {
        
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        var nodeA: AnyObject
        var nodeB: AnyObject
        
        
        if String(describing: type(of: contactA.node!)) == "Bonus" {
            nodeA = contactA.node as! Bonus
            nodeB = contactB.node!
            if countUpdated == false {
                specimenCount += 1
                bioDiversity += 0.01
                let name = nodeA.specimenName
                hitBonus(name: name!)
                countUpdated = true
                print(nodeA.specimenName)
                checkForSpeedIncrease()

            }
            toBeRemoved.append(nodeA as! Bonus)
            return
            
        } else if String(describing: type(of: contactB.node!)) == "Bonus" {
            nodeA = contactA.node!
            nodeB = contactB.node as! Bonus
            if countUpdated == false {
                specimenCount += 1
                bioDiversity += 0.01
                let name = nodeB.specimenName
                hitBonus(name: name!)
                print(nodeB.specimenName)
                countUpdated = true
                checkForSpeedIncrease()
                
            }
            toBeRemoved.append(nodeB as! Bonus)
            return

        } else {
            nodeA = contactA.node!
            nodeB = contactB.node!

        }
        
//        let nodeA = contactA.node as! SKSpriteNode
//        let nodeB = contactB.node as! SKSpriteNode
        
        
        
        /* Check node contact for either a bonus or obstacle */
//        if nodeA.name == "bonus" || nodeB.name == "bonus" {
//            specimenCount += 1
//            bioDiversity += 0.01
//            
//            if nodeA.name == "bonus" {
//                hitBonus()
//                nodeA.removeFromParent()
//            }
//            
//            if nodeB.name == "bonus" {
//                hitBonus()
//                nodeA.removeFromParent()
//            }
//
//        }
        
        /* if the hero hits an obstacle, stop all actions in task */
        
        if nodeA.name == "obstacle" || nodeB.name == "obstacle" {
            print("hit obstacle")
            hitObstacle()
            
        }
        
        if nodeA.name == "log" || nodeB.name == "log" {
            print("hit log")
            hitObstacle()
        }
        
        checkEnd()
        
    }
    
    
    
    
    
    /* Scroll the background */
    func scrollWorld() {
        scrollLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        
        for background in scrollLayer.children as! [SKSpriteNode] {
            /*Get ground node position, convert node position to scene space */
            
            let bgPosition = scrollLayer.convert(background.position, to: self)
            
            /*Check if ground sprite has left the scene */
            if bgPosition.y <= -background.size.height / 2 {
                /*Reposition ground sprite to the second starting position */
                let newPosition = CGPoint(x: bgPosition.x, y: round((self.size.height / 2) + background.size.height))
                /* Convert new node position back to scroll layer space */
                background.position = self.convert(newPosition, to: scrollLayer)
            }
            
            
        }
        
    }
    func scrollObstacles() {
        
        var maxObstacleTimer = 3.8
        
        if specimenCount >= 35 {
            maxObstacleTimer = 2
        }
        
        obstacleLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for object in obstacleLayer.children as! [SKReferenceNode] {
            
            let objectPosition = obstacleLayer.convert(object.position, to: self)
            if objectPosition.y <= -105.18 {
                object.removeFromParent()
            }
            
        }
        
        if obstacleTimer > maxObstacleTimer {
            
            
            let obstacleArray = [sourceYellowObstacle, sourceRedObstacle, sourceObstacle]
            
            /* has to be SKNode bc it's a reference node */
            
            var chosenIndex = Int(randomBetweenNumbers(firstNum: 0, secondNum: 3))
            print(chosenIndex)
            let chosenObstacle = obstacleArray[chosenIndex]!
            
            var newObstacle = chosenObstacle.copy() as! SKNode
            
            /* switch out the houses for their corresponding events */
            if eventName == "chemical event" {
                newObstacle = sourceChemicalObstacle.copy() as! SKNode
            } else if eventName == "heat event" {
                newObstacle = sourceHeatObstacle.copy() as! SKNode
            }
            
            
            
            obstacleLayer.addChild(newObstacle)
            
            let randomPosition = CGPoint(x: CGFloat.random(min:100, max:700), y: 1394)
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            /* reset the timer to doo whop it again */
            
            obstacleTimer = 0
            
            /* shows the tutorial */
            
            let hide: SKAction = SKAction.init(named: "Hide")!
            let wait: SKAction = SKAction.wait(forDuration:2)
            let sequence:SKAction = SKAction.sequence([wait, hide])
            tutorialLabel.run(sequence)
            
            
        }
        
        
    }
    
    
    func scrollLogs() {
        
        
        logLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        /* Logs move across screen */
        
        var maxLogTimer = 3.8
    
        if specimenCount >= 35 {
            maxLogTimer = 2
        }
        
        
        for object in logLayer.children as! [SKReferenceNode] {
            
            let objectPosition = logLayer.convert(object.position, to: self)
            if objectPosition.y <= -10 {
                object.removeFromParent()
            }
            
            /* Regenerate log if it moves off the screen */
            
            if object.position.x >= 845 {
            

//                 log starts off screen on the left b/c 95 is half its width 
               
                let newPosition = CGPoint(x: -95, y: objectPosition.y)
                
                object.position = self.convert(newPosition, to: logLayer)
                
                

            }
            
            object.position.x += logSpeed

            
        }
        
        if logTimer > maxLogTimer {
            
            
            /* has to be SKNode bc it's a reference node */
            
            let newLog = sourceLog.copy() as! SKNode
            logLayer.addChild(newLog)
            
           
            
            let logPosition = CGPoint(x: randomBetweenNumbers(firstNum: CGFloat(minimumWidth), secondNum: CGFloat(maximumWidth)), y: 1900)
            
            
            newLog.position = self.convert(logPosition, to: logLayer)
            
            
            if specimenCount == 19 {
                maximumWidth = 200
                minimumWidth = 55
            }
            
            
            if specimenCount > 20 {
                maximumWidth = 200
                minimumWidth = 55
               
                let newLogDouble = sourceLog.copy() as! SKNode
                logLayer.addChild(newLogDouble)
                let logPositionDouble = CGPoint(x: newLog.position.x + 490, y: 1900)
                
                newLogDouble.position = self.convert(logPositionDouble, to: logLayer)
            }
            

            
            
            /* Log speed must be here in order for each log generated to have a diff. speed */
            
           
            
            logTimer = 0
            
        }
        
        
        
    }
    
    
    /* create bonus objects and scroll them at SAME SPEED as obstacles */
    func scrollBonus() {
        
        var yPos: CGFloat = 1340

        
        var maxBonusTimer = 1.9
        
        if specimenCount >= 35 {
            maxBonusTimer = 2
            yPos = 1860
        }
        
        bonusLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for object in bonusLayer.children as! [Bonus] {
            
            /* gets rid of coins once hit */
            let objectPosition = obstacleLayer.convert(object.position, to: self)
            if objectPosition.y <= -12.5 {
                object.removeFromParent()
            }
            
        }
        
        
        /* the y value must be higher to ensure that the bonuses and obstacles don't overlap */
        
        if bonusTimer >= maxBonusTimer {
            
            
            
            
            
    
//             Choose a specimen randomly 
            let arrayMaxIndex = specimensList.count
            specimenName = specimensList[Int(arc4random_uniform(UInt32(arrayMaxIndex)))]
            
            
            
            let rand = arc4random_uniform(100)
            
            var randomPosition = CGPoint(x: CGFloat.random(min:100, max:250), y: yPos)
    
            
            
            if rand < 70 {
                /* 35% chance of a left side */
                randomPosition = CGPoint(x: CGFloat.random(min:100, max:250), y: yPos)
                
                if rand < 35 {
                    /* 35% chance of a right side */
                    randomPosition = CGPoint(x: CGFloat.random(min:500, max:650), y: yPos)
                }
            }
                
            else {
                /* 30% chance of middle  */
                randomPosition = CGPoint(x: CGFloat.random(min:250, max:500), y: yPos)
            }
            
            /* Add new specimens */
            let newBonus = Bonus(specimenName: specimenName)
            
            bonusLayer.addChild(newBonus)
            newBonus.position = self.convert(randomPosition, to: bonusLayer)

    
            bonusTimer = 0
        }
        
    }
    
    func updateUserDefaults() {
        /* updates every time game scene is displayed */
        
        
        /* sets the events ocurring or not */
        UserDefaults.standard.set(hasDoneHeatEvent, forKey: "hasDoneHeatEvent")
        UserDefaults.standard.set(hasDoneHeroEvent, forKey: "hasDoneHeroEvent")
        UserDefaults.standard.set(hasDoneChemicalEvent, forKey: "hasDoneChemicalEvent")
        UserDefaults.standard.set(hasDoneWindEvent, forKey: "hasDoneWindEvent")
        UserDefaults.standard.set(hasDoneDroughtEvent, forKey: "hasDoneDroughtEvent")
        UserDefaults.standard.set(hasDoneWeatherEvent, forKey: "hasDoneWeatherEvent")
        UserDefaults.standard.set(hasDoneGiraffeEvent, forKey: "hasDoneGiraffeEvent")
        UserDefaults.standard.set(hasDoneSpiderEvent, forKey: "hasDoneSpiderEvent")
        UserDefaults.standard.set(hasDoneTutorialEvent, forKey: "hasDoneTutorialEvent")
        

        
    }

    func levelOver() {
        
        /* Animal counters */
        
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
            case "Fox":
                foxCount += 1
            case "Butterfly":
                butterflyCount += 1
            case "Snake":
                snakeCount += 1
            case "Shark":
                sharkCount += 1
            case "Rabbit":
                rabbitCount += 1
            case "Octopus":
                octopusCount += 1
            case "Cow":
                cowCount += 1
            default:
                return
            }
        }
        
        
        /* User defaults */
        
        UserDefaults.standard.set(totalSpecimens, forKey: "totalSpecimens")
        UserDefaults.standard.set(bioDiversity, forKey: "bioDiversity")
        UserDefaults.standard.set(dayCount, forKey: "dayCount")

        UserDefaults.standard.set(lionCount, forKey: "lionCount")
        UserDefaults.standard.set(sealCount, forKey: "sealCount")
        UserDefaults.standard.set(goldenCount, forKey: "goldenCount")
        UserDefaults.standard.set(giraffeCount, forKey: "giraffeCount")
        UserDefaults.standard.set(chickenCount, forKey: "chickenCount")
        UserDefaults.standard.set(spiderCount, forKey: "spiderCount")
        UserDefaults.standard.set(caterpillarCount, forKey: "caterpillarCount")
        UserDefaults.standard.set(penguinCount, forKey: "penguinCount")
        UserDefaults.standard.set(monkeyCount, forKey: "monkeyCount")
        UserDefaults.standard.set(eagleCount, forKey: "eagleCount")
        UserDefaults.standard.set(pandaCount, forKey: "pandaCount")
        UserDefaults.standard.set(foxCount, forKey: "foxCount")
        UserDefaults.standard.set(butterflyCount, forKey: "butterflyCount")
        UserDefaults.standard.set(snakeCount, forKey: "snakeCount")
        UserDefaults.standard.set(sharkCount, forKey: "sharkCount")
        UserDefaults.standard.set(rabbitCount, forKey: "rabbitCount")
        UserDefaults.standard.set(octopusCount, forKey: "octopusCount")
        UserDefaults.standard.set(cowCount, forKey: "cowCount")
        UserDefaults.standard.synchronize()


    }
    
    func resetUserDefaults() {
        

        UserDefaults.standard.set(0, forKey: "totalSpecimens")
        UserDefaults.standard.set(0, forKey: "dayCount")
        UserDefaults.standard.set(0.4, forKey: "bioDiversity")
        
        UserDefaults.standard.set(0, forKey: "lionCount")
        UserDefaults.standard.set(0, forKey: "sealCount")
        UserDefaults.standard.set(0, forKey: "goldenCount")
        UserDefaults.standard.set(0, forKey: "giraffeCount")
        UserDefaults.standard.set(0, forKey: "chickenCount")
        UserDefaults.standard.set(0, forKey: "spiderCount")
        UserDefaults.standard.set(0, forKey: "caterpillarCount")
        UserDefaults.standard.set(0, forKey: "penguinCount")
        UserDefaults.standard.set(0, forKey: "monkeyCount")
        UserDefaults.standard.set(0, forKey: "eagleCount")
        UserDefaults.standard.set(0, forKey: "pandaCount")
        UserDefaults.standard.set(0, forKey: "foxCount")
        UserDefaults.standard.set(0, forKey: "butterflyCount")
        UserDefaults.standard.set(0, forKey: "snakeCount")
        UserDefaults.standard.set(0, forKey: "sharkCount")
        UserDefaults.standard.set(0, forKey: "rabbitCount")
        UserDefaults.standard.set(0, forKey: "octopusCount")
        UserDefaults.standard.set(0, forKey: "cowCount")
        
        /* resets events and where to start biobar scaling from */
        UserDefaults.standard.set("none", forKey: "eventName")
        UserDefaults.standard.set(0.4, forKey: "previousBioNumber")
        
        /* resets whether or not events have already ocurred */
        UserDefaults.standard.set(false, forKey: "hasDoneHeatEvent")
        UserDefaults.standard.set(false, forKey: "hasDoneHeroEvent")
        UserDefaults.standard.set(false, forKey: "hasDoneChemicalEvent")
        UserDefaults.standard.set(false, forKey: "hasDoneWindEvent")
        UserDefaults.standard.set(false, forKey: "hasDoneDroughtEvent")
        UserDefaults.standard.set(false, forKey: "hasDoneWeatherEvent")
        UserDefaults.standard.set(false, forKey: "hasDoneTutorialEvent")
        
        
        UserDefaults.standard.set(false, forKey: "hasDoneGiraffeEvent")
        UserDefaults.standard.set(false, forKey: "hasDoneSpiderEvent")
        
        UserDefaults.standard.set(false, forKey: "hasWonGame")
        
        UserDefaults.standard.synchronize()

        
    }
    
    func checkForSpeedIncrease() {
        
        if specimenCount == 10 {
            
        } else if specimenCount == 20 {
            scrollSpeed += 10
        } else if specimenCount == 30 {
            scrollSpeed += 20
        } else if specimenCount == 35 {
            scrollSpeed += 100
        }
    }

    
    func checkEnd() {
        if gameState == .gameOver {
            if bioDiversity <= 0.01 {
                loadGameOver()
            } else {
                totalSpecimens += specimenCount
                totalSpecimensLabel.text = "\(totalSpecimens)"
                let scroll:SKAction = SKAction.init(named: "ScrollDown")!
                gameOverMenu.run(scroll)
                dayCount += 1
                levelOver()
                return
            }
        }
    }
    
    func hitBonus(name: String) {
        
        /* show BOKEH ! */
        magicEmitter.isHidden = false
        magicEmitter.resetSimulation()

        /* updates the collected label */
        collectedLabel.text = "\(name) collected! "
        collectedList.append(name)
        collectedLabel.alpha = 1.0
        
        
    }
    
    func hitObstacle() {
        /* change gamestate */
        gameState = .gameOver
        
        /* Stop the hero from moving and stop the scene from scrolling */
        force = 0
        scrollSpeed = 0
        character.physicsBody?.velocity = CGVector(dx:0, dy:0)
        updateUserDefaults()
        
        UserDefaults.standard.set("none", forKey: "eventName")
    }
    
    func loadGameOver() {
        
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
    
}

/* returns a random number */

func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}


//
///* Declare clamping function */
//
//func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
//    return min(max(value, lower), upper)
//}
