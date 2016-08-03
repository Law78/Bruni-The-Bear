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
    
    private var pausePanel: SKSpriteNode?
    
    override func didMoveToView(view: SKView) {
        
        initializeVariables()
        physicsWorld.gravity = CGVectorMake(0, -1.98)
        
        // Devo fare queste impostazioni per il font perchè non me lo fa selezionare nella
        // scena sks :(
        let scoreLabel = self.mainCamera!.childNodeWithName("Score Text") as? SKLabelNode!
        scoreLabel?.fontName = "blow"
        scoreLabel?.fontSize = 28
        
        let lifeScoreLabel = self.mainCamera!.childNodeWithName("Life Score") as? SKLabelNode!
        lifeScoreLabel?.fontName = "blow"
        lifeScoreLabel?.fontSize = 28
        
        let coinScoreLabel = self.mainCamera!.childNodeWithName("Coin Score") as? SKLabelNode!
        coinScoreLabel?.fontName = "blow"
        coinScoreLabel?.fontSize = 28
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
            // Verifico che la scena non sia in pausa per far si che il personaggio
            // risponda ai click solo se la scena è in movimento.
            if self.scene?.paused == false {
                if location.x > center {
                    moveLeft = false
                    //player?.animatePlayer(moveLeft: moveLeft)
                } else {
                    moveLeft = true
                    //player?.animatePlayer(moveLeft: moveLeft)
                }
                player?.animatePlayer(moveLeft: moveLeft)
            }
            
            // Verifico che ho cliccato sul pulsante pausa ma verifico anche che la
            // scena non sia già in pausa.
            if nodeAtPoint(location).name == "Pause" && self.scene?.paused == false {
                self.scene?.paused = true
                createPausePanel()
            }
            
            if nodeAtPoint(location).name == "Resume" {
                pausePanel?.removeFromParent()
                self.scene?.paused = false
            }
            
            if nodeAtPoint(location).name == "Quit" {
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene?.scaleMode = .AspectFill
                self.view?.presentScene(scene!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1.0))
            }

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
        getLabels()
        GameplayController.instance.initializeVariables()
        
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
    
    func getLabels(){
        GameplayController.instance.scoreText = self.mainCamera!.childNodeWithName("Score Text") as? SKLabelNode!
        GameplayController.instance.coinText = self.mainCamera!.childNodeWithName("Coin Score") as? SKLabelNode!
        GameplayController.instance.lifeText = self.mainCamera!.childNodeWithName("Life Score") as? SKLabelNode!
    }
    
    // Funzione per creare il Pause Panel
    func createPausePanel(){
        
        // Il pausePanel sarà in parent con la mainCamera
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeBtn = SKSpriteNode(imageNamed: "Resume Button")
        let quitBtn = SKSpriteNode(imageNamed: "Quit Button 2")
        
        // Posiziono il pannello al centro
        pausePanel?.anchorPoint = CGPoint(x:0.5, y:0.5)
        // Voglio ingrandire un pochino il size del Pause Panel
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 5
        
        // La posizione sarà relativa alla posizione della mainCamera
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2,
            y: (self.mainCamera?.frame.size.height)! / 2 )
        
        // Setto il name dei miei pulsanti perchè mi servirà per il confronto con nodeAtPoint
        resumeBtn.name = "Resume"
        // Il pulsante dovrà avere una zPosition più alta del Pause Panel
        resumeBtn.zPosition = 6
        resumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        quitBtn.name = "Quit"
        quitBtn.zPosition = 6
        quitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        // Aggiungo i pulsanti al pausePanel
        pausePanel?.addChild(resumeBtn)
        pausePanel?.addChild(quitBtn)
        
        // Aggiungo il pausePanel come parent del mainCamera
        self.mainCamera?.addChild(pausePanel!)
        
        
    }
    
    // Aggiunte Lorenzo, una funzione diversa per muovere il background.
    
    func moveBackground(){
        bg1?.moveBackground()
        bg2?.moveBackground()
        bg3?.moveBackground()
    }
}