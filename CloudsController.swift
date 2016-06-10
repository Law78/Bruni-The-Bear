//
//  CloudsController.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 13/05/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import SpriteKit

class CloudsController {
    
    var lastCloudPositionY = CGFloat()
    
    
    func shuffle(var cloudsArray: [SKSpriteNode]) -> [SKSpriteNode]{
        
        /*
            stackoverflow.com/questions/37170203/swift-3-for-loop-with-increment
        */
        // se mettessi for var i, XCode mi propone for let i ma poi otterrei un errore, mi basta togliere var e non aggiungere let. Il pattern for-in utilizza il binding di una costante nello scope che viene creato, pertanto la i è automaticamente una let i loale al for.
        
        for i in (cloudsArray.count-1).stride(to: 0, by: -1){
            let j = Int(arc4random_uniform(UInt32(i - 1)))
            // se i = 9 avrò i - 1 = 8 avrò un numero da 0 a 8 che andrò a sostiture con la posizione i = 9
            
            // faccio lo swap tra questi due elementi in posizione i e j
            swap(&cloudsArray[i], &cloudsArray[j])
        }
        
        return cloudsArray
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        //arc4radom ritorna un numero da 0 a (2**32)-1 cioè un numero moltiplicatio 2 volte 32. Un bel numero :). Lo divido per il massimo UINT32_MAX, moltiplicato il valore assoluto tra la differenza del primo e secondo valore passato, sommato al minimo tra il primo e il secondo valore passato. Tutto ciò ritorna un valore tra i 2 passati. provala con:
        // print("Valore casuale \(randomBetweenNumbers(2, secondNum: 5))")
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
        
    }
    
    func createClouds() -> [SKSpriteNode] {
        

        var clouds = [SKSpriteNode]()
        
        for _ in 0..<2{
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3")
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            cloud1.xScale = 0.9
            cloud1.yScale = 0.9
            cloud2.xScale = 0.9
            cloud2.yScale = 0.9
            cloud3.xScale = 0.9
            cloud3.yScale = 0.9
            darkCloud.xScale = 0.9
            darkCloud.yScale = 0.9
            
            cloud1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: cloud1.size.width - 5, height: cloud1.size.height - 6))
            cloud1.physicsBody?.affectedByGravity = false
            cloud1.physicsBody?.restitution = 0
            cloud1.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud1.physicsBody?.collisionBitMask = ColliderType.Player
            
            cloud2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: cloud2.size.width - 5, height: cloud1.size.height - 6))
            cloud2.physicsBody?.affectedByGravity = false
            cloud2.physicsBody?.restitution = 0
            cloud2.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud2.physicsBody?.collisionBitMask = ColliderType.Player

            
            cloud3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: cloud3.size.width - 5, height: cloud1.size.height - 6))
            cloud3.physicsBody?.affectedByGravity = false
            cloud3.physicsBody?.restitution = 0
            cloud3.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud3.physicsBody?.collisionBitMask = ColliderType.Player
            
            darkCloud.physicsBody = SKPhysicsBody(rectangleOfSize: darkCloud.size)
            darkCloud.physicsBody?.affectedByGravity = false
            darkCloud.physicsBody?.restitution = 0
            darkCloud.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
            darkCloud.physicsBody?.collisionBitMask = ColliderType.Player

            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
            
        }
  
        clouds = shuffle(clouds)
        
        return clouds
    }
    
    func arrangeCloudsInScene(let scene: SKScene, let distanceBetweenClouds: CGFloat, let center: CGFloat, let minX: CGFloat, let maxX: CGFloat, let initialClouds: Bool){
        
        var clouds = createClouds()
        
        if initialClouds {
            while(clouds[0].name == "Dark Cloud"){
                // devo rimischiare l'array. Non posso iniziare con una nube nera!!!
                clouds = shuffle(clouds)
            }
        }
        
        var positionY = CGFloat();
        
        if initialClouds {
            positionY = center - 100
        } else {
            positionY = lastCloudPositionY
        }
        
        var isLeft: Bool = true
        
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat()
            if (isLeft){
                randomX = randomBetweenNumbers(center - 85, secondNum: minX)
                isLeft = !isLeft
                
            } else {
                randomX = randomBetweenNumbers(center + 85, secondNum: maxX)
                isLeft = !isLeft
            }

            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3;

            scene.addChild(clouds[i])
            positionY -= distanceBetweenClouds
            // salvo l'ultima posizione della nuvola, in modo che il nuovo set riprenda da qui
            lastCloudPositionY = positionY

        }
    }
}