//
//  GameplayController.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 03/08/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import Foundation
import SpriteKit

// Classe Singleton

class GameplayController{
    
    // Istruzioni per fare la classe SINGLETON
    static let instance = GameplayController()
    private init() {}
    // Fine istruzioni per fare la classe SINGLETON
    
    // Definizione delle Label, cioè il riferimento alle SKLabelNode che ho nella SCENA del gioco
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    
    // Definizione dei valori
    var score: Int?
    var coin: Int?
    var life: Int?
    
    func initializeVariables(){
        if GameManager.instance.gameStarterdFromMainMenu {
            
            GameManager.instance.gameStarterdFromMainMenu = false
            
            score = 0
            coin = 0
            life = 2
            
            // devo fare l'unwrap perchè sono optional. Se non lo facessi la label scrive vicnio al valore la scritta Optional(...)
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
            
        } else if GameManager.instance.gameRestartedPlayerDied {
            
            GameManager.instance.gameRestartedPlayerDied = false
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
        }
    }
}