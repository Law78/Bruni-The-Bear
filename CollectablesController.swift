// Lezione 48

import SpriteKit

class CollectablesController {
    
    func getCollectable() -> SKSpriteNode {
        
        var collectable = SKSpriteNode()
        
        // Con Int(...) converto un numero del tipo 1.4345792 in 1
        // Faccio lo spawn delle collectables solo se ho un numero maggiore o uguale a 4
        // Devo fare lo spawn di un collectable life o di un coin, inoltre non voglio che il player
        // abbia più di 2 vite (!!!)
        
        if Int( randomBetweenNumbers(0, secondNum: 7)) >= 4 {
            // Maggiore o uguale di 4 faccio lo spawn di una vita
            if GameplayController.instance.life < 2 {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life" // Il nome lo uso per la collisione
                collectable.physicsBody = SKPhysicsBody(rectangleOfSize: collectable.size)
                
            }
        } else {
            
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
        }
        
        // I collectables non devono essere affetti dalla gravità!!!
        collectable.physicsBody?.affectedByGravity = false;
        collectable.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
        collectable.physicsBody?.collisionBitMask = ColliderType.Player
        collectable.zPosition = 2
        
        return collectable
    }
    
    // Ritorna un Float
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        //arc4radom ritorna un numero da 0 a (2**32)-1 cioè un numero moltiplicatio 2 volte 32. Un bel numero :). Lo divido per il massimo UINT32_MAX, moltiplicato il valore assoluto tra la differenza del primo e secondo valore passato, sommato al minimo tra il primo e il secondo valore passato. Tutto ciò ritorna un valore tra i 2 passati. provala con:
        // print("Valore casuale \(randomBetweenNumbers(2, secondNum: 5))")
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
        
    }
    
}