//
//  GameManager.swift
//  Snake_iOS
//
//  Created by Alexandre Touzeau on 1/2/20.
//  Copyright © 2020 Alexandre Touzeau. All rights reserved.
//

import SpriteKit

class GameManager {
    
    //Organizes all of the active SpriteKit content
    var scene: GameScene!
    
    init(scene: GameScene) {
        self.scene = scene
    }
}
