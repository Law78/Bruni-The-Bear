//
//  GameplayScene.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 03/05/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var mainCamera: SKCameraNode?
    var player: Player?
    var canMove: Bool = false
    var moveLeft: Bool = false
    
    var center: CGFloat?
    
    override func didMoveToView(view: SKView) {
        initializeVariables()
    }
    
    override func update(currentTime: NSTimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if location.x > center {
                moveLeft = false
                //player?.animatePlayer(moveLeft: moveLeft)
            } else {
                moveLeft = true
                //player?.animatePlayer(moveLeft: moveLeft)
            }
            player?.animatePlayer(moveLeft: moveLeft)

        }
        
        canMove = true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initializeVariables(){
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNodeWithName("Player") as? Player!
        player?.initializePlayerAndAnimation()
        
        mainCamera = self.childNodeWithName("Main Camera") as? SKCameraNode!
        getBackgrounds()
    }
    
    func getBackgrounds(){
        bg1 = self.childNodeWithName("BG 1") as? BGClass!
        bg2 = self.childNodeWithName("BG 2") as? BGClass!
        bg3 = self.childNodeWithName("BG 3") as? BGClass!
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft)
        }
    }
    
    func moveCamera(){
        self.mainCamera?.position.y -= 8
    }
    
    func manageBackgrounds(){
        bg1?.moveBG(mainCamera!)
        bg2?.moveBG(mainCamera!)
        bg3?.moveBG(mainCamera!)
        print(bg1?.position.y)
    }
}