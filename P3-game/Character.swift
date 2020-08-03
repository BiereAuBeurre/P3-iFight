//
//  Character.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Character {
    var hp: Int = 100
    var weapon: String
    var name: String
    
    init(weapon: String, name: String) {
        self.weapon = weapon
        self.name = name
    }
    
}
