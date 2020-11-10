//
//  Magus.swift
//  P3-game
//
//  Created by Manon Russo on 17/08/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Chevalier: Character {
    init(name: String) {
        let weapon = Sword()
        let type = "Chevalier"
        let healSkill = 25
        super.init(weapon: weapon, type: type, healSkill: healSkill, name: name)
        description = "\n2. \(type) |  ⚔️ Arme : \(weapon.name) (-\(weapon.damages)hp)             | 🏥 Soins : + \(healSkill)hp"
    }
}

