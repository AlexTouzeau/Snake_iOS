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
    
    //Menu
    var gameLogo: SKLabelNode!
    var copyrightLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    var game: GameManager!
    
    //Actual Game
    var currentScore: SKLabelNode!
    var playerPosition: [(Int, Int)] = []
    var gameBackground: SKShapeNode!
    //gameArray will allow us to track down all our cells - It takes a node and a position (x,y)
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    //Function called once our GameScene has loaded
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager(scene: self)
        initializeGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Called before each frame is rendered
    }
    
    
    //Called every time the screen is touched -> We check if a SpriteNode called "play_button" is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
    }
    
    //This function will start the game by hidding our previous objetcs
    private func startGame() {
        print("The game is starting...")
        gameLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
            self.gameLogo.isHidden = true
        }
       
        copyrightLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
            self.copyrightLogo.isHidden = true
        }
        
        playButton.run(SKAction.scale(to: 0, duration : 0.4)) {
            self.playButton.isHidden = true
        }
        
        let rightBottomCorner = CGPoint(x: 170, y: (frame.height / -2) + 20)
        bestScore.run(SKAction.move(to: rightBottomCorner, duration: 0.4)) {
            self.bestScore.run(SKAction.scale(to: 0.50, duration: 0.4))
            //We display our currentScore
            self.currentScore.isHidden = false
            //We display our checkboard
            self.gameBackground.isHidden = false
        }
    }
    
    private func initializeGame() {
        //We put our currentScore in the leftBottomCorner
        currentScore = SKLabelNode(fontNamed: "DIN Condensed")
        currentScore.zPosition = 1
        let leftBottomCorner = CGPoint(x: -210, y: (frame.height / -2) + 20)
        currentScore.position = leftBottomCorner
        currentScore.fontSize = 50
        currentScore.text = "Current Score: 0"
        currentScore.isHidden = true
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
        
        //ShapeNode to represent our gaming area by giving coordinates and dimensions
        let width = 716
        let height = 1158
        let gameArea = CGRect(x: -width/2, y: -height/2 + 70, width: width, height: height)
        gameBackground = SKShapeNode(rect: gameArea, cornerRadius: 0)
        gameBackground.fillColor = SKColor.darkGray
        gameBackground.zPosition = 2
        gameBackground.isHidden = true
        self.addChild(gameBackground)
        
        createSquares(width: width, height: height)
    }
    
    //Will create all the square cells of our checkerboard
    private func createSquares(width: Int, height: Int) {
        let cellWidth: CGFloat = 27.5
        let numRows = 42
        let numCols = 26
        var x = CGFloat(-width / 2) + (cellWidth / 2)
        var y = CGFloat(634)
        //loop in order to create cells
        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                
                //Add to both our array of cells + gaming area
                self.gameArray.append((node: cellNode, x: i, y: j))
                self.gameBackground.addChild(cellNode)
                x += cellWidth
            }
            x = CGFloat(width / -2) + (cellWidth / 2) //Carefull reset x before "writing" a new line
            y -= cellWidth
        }
    }
    
    private func initializeMenu() {
        //Initialize our gameLogo
        gameLogo = SKLabelNode(fontNamed: "DIN Condensed")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height/2) - 300)
        gameLogo.fontSize = 200
        gameLogo.text = "Snake"
        gameLogo.fontColor = SKColor.white
        self.addChild(gameLogo)
        
        //Initiliaze our copyrightLogo
        copyrightLogo = SKLabelNode(fontNamed: "DIN Condensed")
        copyrightLogo.zPosition = 1
        copyrightLogo.position = CGPoint(x: 0, y: (frame.size.height/2) - 390)
        copyrightLogo.fontSize = 50
        copyrightLogo.text = "Alexandre Touzeau"
        copyrightLogo.fontColor = SKColor.red
        self.addChild(copyrightLogo)
        
        //Initialize our bestScore
        bestScore = SKLabelNode(fontNamed: "DIN Condensed")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: copyrightLogo.position.y - 200)
        bestScore.fontSize = 100
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
