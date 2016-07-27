//
//  MainMenuScene.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 10/06/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import SpriteKit

class MainMenuScene : SKScene{
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "Highscore"{
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                scene!.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: .doorsOpenVerticalWithDuration(1))
                
            }
            
            if nodeAtPoint(location).name == "Options"{
                let scene = OptionScene(fileNamed:"OptionScene")
                scene!.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVerticalWithDuration(1))
            }
            
            if nodeAtPoint(location).name == "Start Game"{
                let scene = GameplayScene(fileNamed: "GameplayScene")
                scene?.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVerticalWithDuration(1))
            }
        }
    }
}
