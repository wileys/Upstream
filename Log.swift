//
//  Log.swift
//  Upstream
//
//  Created by Wiley Siler on 7/10/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

class Log: SKReferenceNode {
    
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let logSpeed = CGFloat.random(min: 2.5, max: 5)
    
    func scroll() {
        position.x += logSpeed
    }
    
    //let logSpeed = CGFloat.random(min: 2.5, max: 3.5)
    
            
        
}
