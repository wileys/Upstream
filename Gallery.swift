//
//  Gallery.swift
//  Upstream
//
//  Created by Wiley Siler on 7/12/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit



class Gallery: SKScene {
    /* UI Connections */
    
    var grid: SKSpriteNode!
    
    var goldenCountLabel: SKLabelNode!
    var sealCountLabel: SKLabelNode!
    var giraffeCountLabel: SKLabelNode!
    var lionCountLabel: SKLabelNode!
    var chickenCountLabel: SKLabelNode!
    var spiderCountLabel: SKLabelNode!
    var caterpillarCountLabel: SKLabelNode!
    var penguinCountLabel: SKLabelNode!
    var monkeyCountLabel: SKLabelNode!
    var eagleCountLabel: SKLabelNode!
    var pandaCountLabel: SKLabelNode!
    var foxCountLabel: SKLabelNode!
    var butterflyCountLabel: SKLabelNode!
    var snakeCountLabel: SKLabelNode!
    var sharkCountLabel: SKLabelNode!
    var rabbitCountLabel: SKLabelNode!
    var octopusCountLabel: SKLabelNode!
    var cowCountLabel: SKLabelNode!
    
    var playButton: MSButtonNode!
    var earthButton: MSButtonNode!
    
    /* animals that fall in */
    
    var sourceGolden: SKSpriteNode!
    var sourceLion: SKSpriteNode!
    var sourceSeal:SKSpriteNode!
    var sourceGiraffe: SKSpriteNode!
    var sourceChicken: SKSpriteNode!
    var sourceSpooder: SKSpriteNode!
    var sourceCaterpillar: SKSpriteNode!
    var sourcePenguin: SKSpriteNode!
    var sourceMonkey: SKSpriteNode!
    var sourceEagle: SKSpriteNode!
    var sourcePanda: SKSpriteNode!
    var sourceFox: SKSpriteNode!
    var sourceButterfly: SKSpriteNode!
    var sourceSnake: SKSpriteNode!
    var sourceShark: SKSpriteNode!
    var sourceRabbit: SKSpriteNode!
    var sourceOctopus: SKSpriteNode!
    var sourceCow: SKSpriteNode!
    
//    var sourceSpider: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        
        grid = childNode(withName: "grid") as! SKSpriteNode
        
        goldenCountLabel = grid.childNode(withName: "goldenCountLabel") as! SKLabelNode
        lionCountLabel = grid.childNode(withName: "lionCountLabel") as! SKLabelNode
        sealCountLabel = grid.childNode(withName: "sealCountLabel") as! SKLabelNode
        giraffeCountLabel = grid.childNode(withName: "giraffeCountLabel") as! SKLabelNode
        chickenCountLabel = grid.childNode(withName: "chickenCountLabel") as! SKLabelNode
        spiderCountLabel = grid.childNode(withName: "spiderCountLabel") as! SKLabelNode
        caterpillarCountLabel = grid.childNode(withName: "caterpillarCountLabel") as! SKLabelNode
        penguinCountLabel = grid.childNode(withName: "penguinCountLabel") as! SKLabelNode
        monkeyCountLabel = grid.childNode(withName: "monkeyCountLabel") as! SKLabelNode
        eagleCountLabel = grid.childNode(withName: "eagleCountLabel") as! SKLabelNode
        pandaCountLabel = grid.childNode(withName: "pandaCountLabel") as! SKLabelNode
        foxCountLabel = grid.childNode(withName: "foxCountLabel") as! SKLabelNode
        butterflyCountLabel = grid.childNode(withName: "butterflyCountLabel") as! SKLabelNode
        snakeCountLabel = grid.childNode(withName: "snakeCountLabel") as! SKLabelNode
        sharkCountLabel = grid.childNode(withName: "sharkCountLabel") as! SKLabelNode
        rabbitCountLabel = grid.childNode(withName: "rabbitCountLabel") as! SKLabelNode
        octopusCountLabel = grid.childNode(withName: "octopusCountLabel") as! SKLabelNode
        cowCountLabel = grid.childNode(withName: "cowCountLabel") as! SKLabelNode
        
        /* animals that fall in */

        sourceGolden = childNode(withName: "sourceGolden") as! SKSpriteNode
        sourceLion = childNode(withName: "sourceLion") as! SKSpriteNode
        sourceSeal = childNode(withName: "sourceSeal") as! SKSpriteNode
        sourceGiraffe = childNode(withName: "sourceGiraffe") as! SKSpriteNode
        sourceChicken = childNode(withName: "sourceChicken") as! SKSpriteNode
        sourceSpooder = childNode(withName: "sourceSpooder") as! SKSpriteNode
        sourceCaterpillar = childNode(withName: "sourceCaterpillar") as! SKSpriteNode
        sourcePenguin = childNode(withName: "sourcePenguin") as! SKSpriteNode
        sourceMonkey = childNode(withName: "sourceMonkey") as! SKSpriteNode
        sourceEagle = childNode(withName: "sourceEagle") as! SKSpriteNode
        sourcePanda = childNode(withName: "sourcePanda") as! SKSpriteNode
        sourceFox = childNode(withName: "sourceFox") as! SKSpriteNode
        sourceButterfly = childNode(withName: "sourceButterfly") as! SKSpriteNode
        sourceSnake = childNode(withName: "sourceSnake") as! SKSpriteNode
        sourceShark = childNode(withName: "sourceShark") as! SKSpriteNode
        sourceRabbit = childNode(withName: "sourceRabbit") as! SKSpriteNode
        sourceOctopus = childNode(withName: "sourceOctopus") as! SKSpriteNode
        sourceCow = childNode(withName: "sourceCow") as! SKSpriteNode
        
        playButton = childNode(withName: "playButton") as! MSButtonNode
        earthButton = childNode(withName: "earthButton") as! MSButtonNode
        
        playButton.selectedHandler = { [unowned self] in
            self.removeAllChildren()
            self.removeAllActions()
            self.loadGame()
        }
        
        
        earthButton.selectedHandler = { [unowned self] in
            self.removeAllChildren()
            self.removeAllActions()
            self.loadEarth()
        }
        
        goldenCountLabel.text = String(goldenCount)
        lionCountLabel.text = String(lionCount)
        sealCountLabel.text = String(sealCount)
        giraffeCountLabel.text = String(giraffeCount)
        chickenCountLabel.text = String(chickenCount)
        spiderCountLabel.text = String(spiderCount)
        caterpillarCountLabel.text = String(caterpillarCount)
        penguinCountLabel.text = String(penguinCount)
        monkeyCountLabel.text = String(monkeyCount)
        eagleCountLabel.text = String(eagleCount)
        pandaCountLabel.text = String(pandaCount)
        foxCountLabel.text = String(foxCount)
        butterflyCountLabel.text = String(pandaCount)
        snakeCountLabel.text = String(snakeCount)
        sharkCountLabel.text = String(sharkCount)
        rabbitCountLabel.text = String(rabbitCount)
        octopusCountLabel.text = String(octopusCount)
        cowCountLabel.text = String(cowCount)
        
        specimensFall(animalCount: goldenCount, sourceAnimal: sourceGolden)
        specimensFall(animalCount: lionCount, sourceAnimal: sourceLion)
        specimensFall(animalCount: sealCount, sourceAnimal: sourceSeal)
        specimensFall(animalCount: giraffeCount, sourceAnimal: sourceGiraffe)
        specimensFall(animalCount: chickenCount, sourceAnimal: sourceChicken)
        specimensFall(animalCount: spiderCount, sourceAnimal: sourceSpooder)
        specimensFall(animalCount: caterpillarCount, sourceAnimal: sourceCaterpillar)
        specimensFall(animalCount: penguinCount, sourceAnimal: sourcePenguin)
        specimensFall(animalCount: monkeyCount, sourceAnimal: sourceMonkey)
        specimensFall(animalCount: eagleCount, sourceAnimal: sourceEagle)
        specimensFall(animalCount: pandaCount, sourceAnimal: sourcePanda)
        specimensFall(animalCount: foxCount, sourceAnimal: sourceFox)
        specimensFall(animalCount: butterflyCount, sourceAnimal: sourceButterfly)
        specimensFall(animalCount: snakeCount, sourceAnimal: sourceSnake)
        specimensFall(animalCount: sharkCount, sourceAnimal: sourceShark)
        specimensFall(animalCount: rabbitCount, sourceAnimal: sourceRabbit)
        specimensFall(animalCount: octopusCount, sourceAnimal: sourceOctopus)
        specimensFall(animalCount: cowCount, sourceAnimal: sourceCow)


    }
    
    func loadEarth() {
        /* 1) Grab reference to our SpriteKit view */
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
    
    /* HAve specimens fall from the sky if they are accounted for */
    
    func specimensFall(animalCount: Int, sourceAnimal: SKSpriteNode) {
        if animalCount > 0 {
            let newAnimal = sourceAnimal.copy() as! SKSpriteNode
            newAnimal.physicsBody?.affectedByGravity = true
            newAnimal.physicsBody?.isDynamic = true
            sourceAnimal.addChild(newAnimal)
            newAnimal.zPosition = 5
        }
    }
    
}
