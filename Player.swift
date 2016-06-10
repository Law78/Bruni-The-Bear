//
//  Player.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 03/05/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import SpriteKit

struct ColliderType{
    static let Player: UInt32 = 0
    static let Cloud: UInt32 = 1
    static let DarkCloudAndCollectables: UInt32 = 2
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction();
    
    
    func initializePlayerAndAnimation(){
        textureAtlas = SKTextureAtlas(named: "Player")
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            //playerAnimation.append(SKTexture(imageNamed: name))
            playerAnimation.append(textureAtlas.textureNamed(name))
        }
        
        animatePlayerAction = SKAction.animateWithTextures(playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width - 50, height: self.size.height - 5))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Cloud
        self.physicsBody?.contactTestBitMask = ColliderType.DarkCloudAndCollectables
    }
    
    func animatePlayer(moveLeft moveLeft: Bool){
        
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else {
            self.xScale = fabs(self.xScale)
        }
        self.runAction(SKAction.repeatActionForever(animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation(){
        self.removeActionForKey("Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool){
        if moveLeft {
            self.position.x -= 7
        } else {
            self.position.x += 7
        }
    }
}
