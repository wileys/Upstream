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

var bioDiversity: Double {
    get {
        return UserDefaults.standard.double(forKey: "bioDiversity")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "bioDiversity")
    }
}


var dayCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "dayCount")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "dayCount")
    }
}


var totalSpecimens: Int {
    get {
        return UserDefaults.standard.integer(forKey: "totalSpecimens")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "totalSpecimens")
    }
}

var collectedList = [String]()



var width: CGFloat = 0
var height: CGFloat = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let motionManager = CMMotionManager()
    var character: Character!
    var specimenCount: Int = 0
    var gameState: GameState = .playing
    var force: CGFloat = 1400
    var scrollLayer: SKNode!
    var scrollSpeed: CGFloat = 130
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    var sourceObstacle: SKNode!
    var obstacleLayer: SKNode!
    var bonusLayer: SKNode!
    var obstacleTimer: CFTimeInterval = 0
    var bonusTimer: CFTimeInterval = 0
    var logTimer: CFTimeInterval = 0
    var sourceBonus: SKNode!
    var logLayer: SKNode!
    var sourceLog: SKNode!
    var specimenCounter: SKLabelNode!
    var logSpeed: CGFloat = 4
    var gameOverMenu: SKSpriteNode!
    var totalSpecimensLabel: SKLabelNode!
    var earthButton: MSButtonNode!
    
    var collectedLabel: SKLabelNode!
    
    
    let specimensList = ["Lion", "Giraffe", "Golden Retriever", "Seal"]
    var specimenName = ""
    
    /* Tutorial thumbs */
    var tutorialLabel: SKLabelNode!
   
    
    
    override func didMove(to view: SKView) {
        
        if bioDiversity <= 0.01 {
            resetUserDefaults()
            print("SAD")
        }
        
        
        bioDiversity -= 0.10
        gameState = .playing

        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        character = childNode(withName: "character") as! Character
        scrollLayer = self.childNode(withName: "scrollLayer")
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        sourceObstacle = self.childNode(withName: "obstacle")
        bonusLayer = self.childNode(withName: "bonusLayer")
        sourceBonus = self.childNode(withName: "bonus")
        logLayer = self.childNode(withName: "logLayer")
        sourceLog = self.childNode(withName:"log")
        specimenCounter = childNode(withName: "specimenCounter") as! SKLabelNode
        gameOverMenu = childNode(withName: "gameOverMenu") as! SKSpriteNode
        totalSpecimensLabel = gameOverMenu.childNode(withName: "totalSpecimensLabel") as! SKLabelNode
        earthButton = gameOverMenu.childNode(withName: "earthButton") as! MSButtonNode
        
        tutorialLabel = childNode(withName: "tutorialLabel") as! SKLabelNode
        collectedLabel = childNode(withName: "collectedLabel") as! SKLabelNode
        
        collectedLabel.alpha = 0.0
        
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
        
        earthButton.selectedHandler = {
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
        
        /* timers count */
        obstacleTimer += fixedDelta
        bonusTimer += fixedDelta
        logTimer += fixedDelta
        
        specimenCounter.text = "\(specimenCount)"
        
        
    }
    
    func didBegin (_ contact: SKPhysicsContact) {
        
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        
        /* Check node contact for either a bonus or obstacle */
        if nodeA.name == "bonus" || nodeB.name == "bonus" {
            specimenCount += 1
            bioDiversity += 0.01
            print(specimenCount)
            
            
            if nodeA.name == "bonus" {
            
//                switch nodeA.color {
//                case UIColor(red:0.91, green:0.78, blue:0.87, alpha:1.0):
//                    specimenName = "Lion"
//                    
//                case UIColor(red:0.60, green:0.89, blue:0.78, alpha:1.0):
//                    specimenName = "Seal"
//                    
//                case UIColor(red:0.55, green:0.42, blue:0.58, alpha:1.0):
//                    specimenName = "Golden Retriever"
//                    
//                case UIColor(red:0.62, green:0.89, blue:0.49, alpha:1.0):
//                    specimenName = "Giraffe"
//                    
//                default:
//                    return
//                }

                
                hitBonus()
                nodeA.removeFromParent()
            }
            
            if nodeB.name == "bonus" {
                hitBonus()
                nodeA.removeFromParent()
            }

        }
        
        /* if the hero hits an obstacle, stop all actions in task */
        
        if nodeA.name == "obstacle" || nodeB.name == "obstacle" {
            /* change gamestate */
            gameState = .gameOver
            print("Game over")
            /* Stop the hero from moving and stop the scene from scrolling */
            force = 0
            scrollSpeed = 0
            character.physicsBody?.velocity = CGVector(dx:0, dy:0)
            updateUserDefaults()
            
        }
        
        if nodeA.name == "log" || nodeB.name == "log" {
            /* If the hero hits a moving log, stop the game */
            gameState = .gameOver
            print("Game over")
            force = 0
            scrollSpeed = 0
            character.physicsBody?.velocity = CGVector(dx:0, dy:0)
            updateUserDefaults()
            
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
                let newPosition = CGPoint(x: bgPosition.x, y: (self.size.height / 2) + background.size.height)
                /* Convert new node position back to scroll layer space */
                background.position = self.convert(newPosition, to: scrollLayer)
            }
            
            
        }
        
    }
    func scrollObstacles() {
        
        
        obstacleLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for object in obstacleLayer.children as! [SKReferenceNode] {
            
            let objectPosition = obstacleLayer.convert(object.position, to: self)
            if objectPosition.y <= -10 {
                object.removeFromParent()
            }
            
        }
        
        if obstacleTimer > 4 {
            
            /* has to be SKNode bc it's a reference node */
            
            let newObstacle = sourceObstacle.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            let randomPosition = CGPoint(x: CGFloat.random(min:100, max:700), y: 1334)
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            obstacleTimer = 0
            
            let hide: SKAction = SKAction.init(named: "Hide")!
            tutorialLabel.run(hide)
            
            
        }
        
        
    }
    
    
    func scrollLogs() {
        
        
        logLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        /* Logs move across screen */
    

        
        
        
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
        
        if logTimer > 4 {
            
            
            /* has to be SKNode bc it's a reference node */
            
            let newLog = sourceLog.copy() as! SKNode
            logLayer.addChild(newLog)
            
            let logPosition = CGPoint(x: CGFloat.random(min: 55, max: 700), y: 1524)
            newLog.position = self.convert(logPosition, to: logLayer)
            
            /* Log speed must be here in order for each log generated to have a diff. speed */
            
            logSpeed = CGFloat.random(min: 3.5, max: 4)
            
            logTimer = 0
            
        }
        
        
        
    }
    
    
    /* create bonus objects and scroll them at SAME SPEED as obstacles */
    func scrollBonus() {
        bonusLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for object in bonusLayer.children as! [SKSpriteNode] {
            
            /* gets rid of coins once hit */
            let objectPosition = obstacleLayer.convert(object.position, to: self)
            if objectPosition.y <= -12.5 {
                object.removeFromParent()
            }
            
        }
        
        /* the y value must be higher to ensure that the bonuses and obstacles don't overlap */
        
        if bonusTimer > 4 {
            
    
//             Choose a specimen randomly 
            let arrayMaxIndex = specimensList.count
            specimenName = specimensList[Int(arc4random_uniform(UInt32(arrayMaxIndex)))]

            
            
            let rand = arc4random_uniform(100)
            
            var randomPosition = CGPoint(x: CGFloat.random(min:100, max:250), y: 1650)
            
            
            if rand < 70 {
                /* 35% chance of a left side */
                randomPosition = CGPoint(x: CGFloat.random(min:100, max:250), y: 1650)
                
                if rand < 35 {
                    /* 35% chance of a right side */
                    randomPosition = CGPoint(x: CGFloat.random(min:500, max:650), y: 1650)
                }
            }
                
            else {
                /* 30% chance of middle  */
                randomPosition = CGPoint(x: CGFloat.random(min:250, max:500), y: 1650)
            }
            
            /* Add new coins */
            let newBonus = sourceBonus.copy() as! SKNode
            bonusLayer.addChild(newBonus)
            print("I work")
            
            //            let randomPosition = CGPoint(x: CGFloat.random(min:100, max:650), y: 1474)
            newBonus.position = self.convert(randomPosition, to: bonusLayer)

    
            bonusTimer = 0
        }
        
    }
    
    func updateUserDefaults() {
        
        totalSpecimens += specimenCount
        UserDefaults.standard.set(totalSpecimens, forKey: "totalSpecimens")
        
        UserDefaults.standard.set(bioDiversity, forKey: "bioDiversity")
        
        UserDefaults.standard.set(dayCount, forKey: "dayCount")
        
        UserDefaults.standard.set(lionCount, forKey: "lionCount")
        
        UserDefaults.standard.set(sealCount, forKey: "sealCount")
        
        UserDefaults.standard.set(goldenCount, forKey: "goldenCount")
        
        UserDefaults.standard.set(giraffeCount, forKey: "giraffeCount")
        
        
//        let retrieve = UserDefaults.standard.integer(forKey: "dayCount")
//        print(retrieve)

    }
    
    func resetUserDefaults() {
        
        UserDefaults.standard.set(0, forKey: "totalSpecimens")
        
        UserDefaults.standard.set(0, forKey: "dayCount")
        
        UserDefaults.standard.set(0.4, forKey: "bioDiversity")
        
        UserDefaults.standard.set(0, forKey: "lionCount")
        
        UserDefaults.standard.set(0, forKey: "sealCount")
        
        UserDefaults.standard.set(0, forKey: "goldenCount")
        
        UserDefaults.standard.set(0, forKey: "giraffeCount")
        

        
    }

    
    func checkEnd() {
        if gameState == .gameOver {
            totalSpecimensLabel.text = "\(totalSpecimens)"
            let scroll:SKAction = SKAction.init(named: "ScrollDown")!
            gameOverMenu.run(scroll)
            dayCount += 1
            return
        }
    }
    
    func hitBonus() {
        var emoji = "🦁"
        switch specimenName {
        case "Lion":
            emoji = "🦁"
        case "Giraffe":
            emoji = "🦌"
        case "Golden Retriever":
            emoji = "🐶"
        case "Seal":
            emoji = "🐳"
        default:
            return
        }
        
        collectedLabel.text = "\(specimenName) collected ! " + emoji
        print(specimenName)
        collectedList.append(specimenName)
        collectedLabel.alpha = 1.0
        let hide:SKAction = SKAction(named: "Hide")!
        let wait:SKAction = SKAction.wait(forDuration:0.5)
        let sequence = SKAction.sequence([wait, hide])
        collectedLabel.run(sequence)
        
        
    }
    
    

    
}

/* Declare clamping function */

func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}
