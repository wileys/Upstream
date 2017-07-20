//
//  Bonus.swift
//  Upstream
//
//  Created by Wiley Siler on 7/18/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

class Bonus: SKSpriteNode {
 
    var specimenName: String!
    var specimenTexture: SKTexture!
    var isContacted = true
    
//    override init(texture:SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture:texture, color:color, size: size)
//        
//    }
    
    /* You are required to implement this for your subclass to work */
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    init(specimenName: String) {
        
        switch specimenName {
        case "Lion":
            specimenTexture = SKTexture(imageNamed: "lion")
            //print("Sfsdf")
        case "Giraffe":
            specimenTexture = SKTexture(imageNamed: "giraffe")
        case "Golden Retriever":
            specimenTexture = SKTexture(imageNamed: "doge")
        case "Seal":
            specimenTexture = SKTexture(imageNamed: "seal")
        case "Chicken":
            specimenTexture = SKTexture(imageNamed: "chicken")
        case "Spider":
            specimenTexture = SKTexture(imageNamed: "spooder")
            //
            //        case "Caterpillar":
            //
            //        case "Penguin":
            //
            //        case "Monkey":
            //
            //        case "Eagle":
            //
            //        case "Panda":
            //
            //        case "Fox":
            //
            //        case "Butterfly":
            //
            //        case "Snake":
            //
            //        case "Shark":
            //
            //        case "Rabbit":
            //
            //        case "Octopus":
            //
            //        case "Cow":
        //
        default:
            specimenTexture = SKTexture(imageNamed:"lion")
            
        }

        
        
        super.init(texture: specimenTexture, color: UIColor.clear, size: specimenTexture.size())
        
        self.specimenName = specimenName
        self.physicsBody = SKPhysicsBody(texture: specimenTexture,
                                                      size: CGSize(width: size.width,
                                                                   height: size.height))
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 1
        self.zPosition = 4
        
    }
    
    
    
    
    
}
