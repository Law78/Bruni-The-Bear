//
//  HishscoreScene.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 10/06/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import SpriteKit

class HighscoreScene : SKScene{
    var highscoreLabel: SKLabelNode?
    var coinLabel: SKLabelNode?
    
    override func didMoveToView(view: SKView) {
        highscoreLabel = self.childNodeWithName("Score Label") as? SKLabelNode!
        highscoreLabel?.fontName = "blow"
        highscoreLabel?.fontSize = 28
        
        coinLabel = self.childNodeWithName("Coin Label") as? SKLabelNode!
        coinLabel?.fontName = "Minecraft"
        coinLabel?.fontSize = 16
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            if nodeAtPoint(location).name == "Back Button"{
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene?.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1.0))
            }
        }
    }
}