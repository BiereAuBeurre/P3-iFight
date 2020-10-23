//
//  Weapon.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Weapon {
    var damages: Int
    var name: String
    var healSkill: Int
    
    init(damages: Int, name: String, healSkill: Int) {
        self.damages = damages
        self.name = name
        self.healSkill = healSkill
    }
}
