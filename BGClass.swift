//
//  BGClass.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 06/05/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode{
    
    func moveBG(camera: SKCameraNode){
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3
        }
    }
    
    func moveBackground(){
        if (self.position.y) <= (self.size.height * (-2)){
            self.position.y = self.size.height - 10
        } else {
          self.position.y -= 8
        }
        print(self.position.y)
    }
}
