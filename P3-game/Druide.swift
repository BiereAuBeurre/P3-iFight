//
//  Dwarf.swift
//  P3-game
//
//  Created by Manon Russo on 17/08/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Druide: Character {
    init(name: String) {
        let weapon = Fate()
        let type = "Druide"
        let healSkill = 15
        let description = "\n4.  \(type)   |  ⚔️ Arme : \(weapon.name) (-\(weapon.damages)hp)             | 🏥 Soins : + \(healSkill)hp"
        super.init(weapon: weapon, type: type, healSkill: healSkill, name: name, description: description)
    }
}
