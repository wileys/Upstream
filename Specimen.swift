//
//  Specimen.swift
//  Upstream
//
//  Created by Wiley Siler on 7/12/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

class Specimen: SKSpriteNode {
    
    
    
    override init(texture: SKTexture?, color:UIColor, size: CGSize) {
        super.init(texture:texture, color: color, size: size)
        isUserInteractionEnabled = false
        
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

}
