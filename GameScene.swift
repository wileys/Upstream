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
    var logSpeed: CGFloat = 0
    
    
    override func didMove(to view: SKView) {
        
        
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

//        /* Set up accelerometer */
//        motionManager.startAccelerometerUpdates()
//        motionManager.accelerometerUpdateInterval = 0.1
//        character.physicsBody!.linearDamping = 0
        
        character.isUserInteractionEnabled = true
        
        height = self.size.height
        width = self.size.width
    
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
        // Called before each frame is rendered
        
//        let targetX = character.position.x
        
//        /* Set boundaries */
//        let x = clamp(value: targetX, lower: 50, upper: 710)
//        character.position.x = x
        
        
//        guard let data = motionManager.accelerometerData else { return }
//        
//        /* Alters force applied with tilt */
//        character.physicsBody?.applyForce(CGVector(dx: force * CGFloat(data.acceleration.x), dy: 0 * CGFloat(data.acceleration.x)))
        
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
//        let contactA = contact.bodyA
//        let contactB = contact.bodyB
//        
//        let nodeA = contactA.node!
//        let nodeB = contactB.node!
//        
//        if nodeA.name == "bonus" || nodeB.name = "bonus" {
//            specimenCount += 1
//            print(specimenCount)
//            return
//        }
        
        
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
    
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        
        /* Check node contact for either a bonus or obstacle */
        if nodeA.name == "bonus" || nodeB.name == "bonus" {
            specimenCount += 1
            print(specimenCount)
            
            if nodeA.name == "bonus" {
                nodeA.removeFromParent()
            }
            
            if nodeB.name == "bonus" {
                nodeB.removeFromParent()
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
            return
        }
        
        if nodeA.name == "log" || nodeB.name == "log" {
            /* If the hero hits a moving log, stop the game */
            gameState = .gameOver
            print("Game over")
            force = 0
            scrollSpeed = 0
            character.physicsBody?.velocity = CGVector(dx:0, dy:0)
            return
        }

        
        
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
        
        if obstacleTimer > 5 {
            
            /* has to be SKNode bc it's a reference node */
            
            let newObstacle = sourceObstacle.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            let randomPosition = CGPoint(x: CGFloat.random(min:100, max:700), y: 1334)
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            
            obstacleTimer = 0
            
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
            
            if objectPosition.x >= 750 + 95 {
                /* log starts off screen on the left b/c 95 is half its width */
                let newPosition = CGPoint(x: -95, y: objectPosition.y)
                
                object.position = self.convert(newPosition, to: logLayer)
            }
            object.position.x += CGFloat(logSpeed)

            
            
        }
        
        if logTimer > 5 {
            
            logSpeed += 0.2
            
            /* has to be SKNode bc it's a reference node */
            
            let newLog = sourceLog.copy() as! SKNode
            logLayer.addChild(newLog)
            
            let logPosition = CGPoint(x: 50, y: 1604)
            newLog.position = self.convert(logPosition, to: logLayer)
            
            /* Log speed must be here in order for each log generated to have a diff. speed */
            
            logSpeed = CGFloat.random(min: 2.5, max: 3.5)

            logTimer = 0
            
        }
        
       
        
    }
   
    
    /* create bonus objects and scroll them at SAME SPEED as obstacles */
    func scrollBonus() {
        bonusLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for object in bonusLayer.children as! [SKReferenceNode] {
            
            /* gets rid of coins once hit */
            let objectPosition = obstacleLayer.convert(object.position, to: self)
            if objectPosition.y <= -12.5 {
                object.removeFromParent()
            }
            
        }
    
        /* the y value must be higher to ensure that the bonuses and obstacles don't overlap */
        
        if bonusTimer > 5 {
            
            /* Random Number Generator */
            let rand = arc4random_uniform(100)
            
            var randomPosition = CGPoint(x: CGFloat.random(min:100, max:250), y: 1800)
            
            
            if rand < 70 {
                /* 35% chance of a left side */
                randomPosition = CGPoint(x: CGFloat.random(min:100, max:250), y: 1800)
                
                if rand < 35 {
                    /* 35% chance of a right side */
                    randomPosition = CGPoint(x: CGFloat.random(min:500, max:650), y: 1800)
                }
            }
            
            else {
                /* 30% chance of middle  */
                randomPosition = CGPoint(x: CGFloat.random(min:250, max:500), y: 1500)
            }
           
            /* Add new coins */
            let newBonus = sourceBonus.copy() as! SKNode
            bonusLayer.addChild(newBonus)
            
//            let randomPosition = CGPoint(x: CGFloat.random(min:100, max:650), y: 1474)
            newBonus.position = self.convert(randomPosition, to: bonusLayer)
            
            bonusTimer = 0
        }

    }
    
    
    
  
    
}

/* Declare clamping function */

func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}
