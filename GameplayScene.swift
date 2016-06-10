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
    
    var cloudsController = CloudsController()
    var mainCamera: SKCameraNode?
    var player: Player?
    var canMove: Bool = false
    var moveLeft: Bool = false
    
    var center: CGFloat?
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    let distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-152)
    let maxX = CGFloat(152)
    
    override func didMoveToView(view: SKView) {
        initializeVariables()
        physicsWorld.gravity = CGVectorMake(0, -1.98)
    }
    
    override func update(currentTime: NSTimeInterval) {
        moveCamera()
        //moveBackground()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
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
        cloudsController.arrangeCloudsInScene(self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
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
        //print(bg1?.position.y)
    }
    
    func createNewClouds(){
        if (cameraDistanceBeforeCreatingNewClouds > mainCamera?.position.y){
            
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
            
            cloudsController.arrangeCloudsInScene(self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: false)
        }
    }
    
    // Aggiunte Lorenzo
    
    func moveBackground(){
        bg1?.moveBackground()
        bg2?.moveBackground()
        bg3?.moveBackground()
    }
}