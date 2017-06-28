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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let motionManager = CMMotionManager()
    var character: SKSpriteNode!
    var specimenCount: Int = 0
    var gameState: GameState = .playing
    var force: CGFloat = 500
    var scrollLayer: SKNode!
    var scrollSpeed: CGFloat = 100
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    var sourceObstacle: SKNode!
    var obstacleLayer: SKNode!
    var bonusLayer: SKNode!
    var obstacleTimer: CFTimeInterval = 0
    var bonusTimer: CFTimeInterval = 0
    var sourceBonus: SKNode!
    
    
    override func didMove(to view: SKView) {
        
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        character = childNode(withName: "character") as! SKSpriteNode
        scrollLayer = self.childNode(withName: "scrollLayer")
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        sourceObstacle = self.childNode(withName: "obstacle")
        bonusLayer = self.childNode(withName: "bonusLayer")
        sourceBonus = self.childNode(withName: "bonus")

        /* Set up accelerometer */
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.01
        character.physicsBody!.linearDamping = 0
        
        
        
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
        
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        let targetX = character.position.x
        
        /* Set boundaries */
        let x = clamp(value: targetX, lower: 50, upper: 710)
        character.position.x = x
        
        
        guard let data = motionManager.accelerometerData else { return }
    
        
        /* Alters force applied with tilt */
        character.physicsBody?.applyForce(CGVector(dx: force * CGFloat(data.acceleration.x), dy: 0 * CGFloat(data.acceleration.x)))
        
        scrollWorld()
        if scrollSpeed > 0 {
            scrollObstacles()
            scrollBonus()
        }
        obstacleTimer += fixedDelta
        bonusTimer += fixedDelta

        
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
        
        
        
        if nodeA.name == "obstacle" || nodeB.name == "obstacle" {
            gameState = .gameOver
            print("Game over")
            force = 0
            character.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            scrollSpeed = 0
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
        
        if obstacleTimer > 3.5 {
            
            /* has to be SKNode bc it's a reference node */
            
            let newObstacle = sourceObstacle.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            let randomPosition = CGPoint(x: CGFloat.random(min:100, max:700), y: 1334)
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            
            obstacleTimer = 0
            
        }
    
    }
   
    
    func scrollBonus() {
        bonusLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for object in bonusLayer.children as! [SKReferenceNode] {
            
            /* gets rid of coins once hit */
            let objectPosition = obstacleLayer.convert(object.position, to: self)
            if objectPosition.y <= -12.5 {
                object.removeFromParent()
            }
            
        }
        
        if bonusTimer > 3.5 {
            let newBonus = sourceBonus.copy() as! SKNode
            bonusLayer.addChild(newBonus)
            
            let randomPosition = CGPoint(x: CGFloat.random(min:0, max:750), y: 1474)
            newBonus.position = self.convert(randomPosition, to: bonusLayer)
            
            bonusTimer = 0
        }

    }
  
    
}

/* Declare clamping function */

func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}
