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
    
    // The "?" here is necessary because we want our var to be nil sometimes
    //This is the nextTime interval we will print a statement to the console
    var nextTime: Double?
    
    //How long we will wait between each call - determine the speed
    var timeExtension: Double = 0.5
    
    //By default our player is going left
    var playerDirection: Int = 1 //1 = left ; 2 = up ; 3 = right ; 4 = down
    
    //Snake Size is at the begining 4
    var currentSnakeSize = 4
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func initGame() {
        //starting player position
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((11, 10))
        scene.playerPositions.append((12, 10))
        scene.playerPositions.append((13, 10))
        renderChange()
    }
    
    //We need to define the "contains" function because the standard one seems not working with tuple
    private func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
      let (c1, c2) = v
      for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
      return false
    }
    
    func renderChange() {
        for (node, x, y) in scene.gameArray {
           if contains(a: scene.playerPositions, v: (x,y)) {
                node.fillColor = SKColor.white
            } else {
                node.fillColor = SKColor.clear
            }
        }
    }
    
    /* 60 fps = called 60 times per second
    We want to update our position only one time per sec
    Our function produce only one output per sec
    To increase speed we could lower timeExtension but carefull that
    timeExtension remains greater than 0 */
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
                changeSpeed()
            }
        }
    }
    
    private func changeSpeed() {
        let size = scene.playerPositions.count
        if size > 0 && (self.currentSnakeSize != size) {
            self.timeExtension = timeExtension / (Double(size) / 4)
            self.currentSnakeSize = size
        }
    }
    
    private func updatePlayerPosition() {
        var xChange = -1
        var yChange = 0
        switch playerDirection {
        case 1: // left
            xChange = -1
            yChange = 0
            break
        case 2: //up
            xChange = 0
            yChange = -1
            break
        case 3: //right
            xChange = 1
            yChange = 0
            break
        case 4: //down
        xChange = 0
        yChange = 1
        break
        default:
            break
        
        }
        //Will move the rest of the body of our snake
        //This "body" is materialized here by the positions forward in the array
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            //We move the head of our snake
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        //Need to render new positions of playerPositions
        renderChange()
    }
    
    //This function is necessary because some move are impossible
    func swipe(d: Int) {
        if !(d == 2 && playerDirection == 4) && !(d == 4 && playerDirection == 2) {
            if !(d == 1 && playerDirection == 3) && !(d == 3 && playerDirection == 1) {
                self.playerDirection = d
            }
        }
    }
}
