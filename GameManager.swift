//
//  GameController.swift
//  Bruni The Bear
//
//  Created by Lorenzo on 03/08/16.
//  Copyright © 2016 Lorenzo Franceschini. All rights reserved.
//

import Foundation

class GameManager{
    // Istruzioni per fare la classe SINGLETON
    static let instance = GameManager()
    private init() {}
    // Fine istruzioni per fare la classe SINGLETON
    
    // Meccanismi di controllo per capire da dove parte il gioco e quindi fare i settaggi
    var gameStarterdFromMainMenu = false
    var gameRestartedPlayerDied = false

}