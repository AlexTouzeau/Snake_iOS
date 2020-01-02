//
//  GameScene.swift
//  Snake_iOS
//
//  Created by Alexandre Touzeau on 1/2/20.
//  Copyright © 2020 Alexandre Touzeau. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //This var must be initialized
    var gameLogo: SKLabelNode!
    var copyrightLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    
    //Function called once our GameScene has loaded
    override func didMove(to view: SKView) {
        initializeMenu()
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Called before each frame is rendered
    }
    
    private func initializeMenu() {
        //Initialize our gameLogo
        gameLogo = SKLabelNode(fontNamed: "IBM 3270")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height/2) - 300)
        gameLogo.fontSize = 150
        gameLogo.text = "Snake"
        gameLogo.fontColor = SKColor.white
        self.addChild(gameLogo)
        
        //Initiliaze our copyrightLogo
        copyrightLogo = SKLabelNode(fontNamed: "IBM 3270")
        copyrightLogo.zPosition = 1
        copyrightLogo.position = CGPoint(x: 0, y: (frame.size.height/2) - 390)
        copyrightLogo.fontSize = 50
        copyrightLogo.text = "Alexandre Touzeau"
        copyrightLogo.fontColor = SKColor.red
        self.addChild(copyrightLogo)
        
        //Initialize our bestScore
        bestScore = SKLabelNode(fontNamed: "IBM 3270")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: copyrightLogo.position.y - 200)
        bestScore.fontSize = 50
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
    
        //initialize our playButton
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 300)
        playButton.fillColor = SKColor.white
        let topCorner = CGPoint(x: -65, y: 65)
        let bottomCorner = CGPoint(x: -65, y: -65)
        let middle = CGPoint(x: 65, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
        
        
        
        
    }
}
