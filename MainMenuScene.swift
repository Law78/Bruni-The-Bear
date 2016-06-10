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
        }
    }
}
