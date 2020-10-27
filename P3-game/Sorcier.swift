//
//  Colossus.swift
//  P3-game
//
//  Created by Manon Russo on 17/08/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Sorcier: Character {
    init() {
        let weapon = MagicPotion()
        let type = "Sorcier"
        let healSkill = 20
        super.init(weapon: weapon, type: type, healSkill: healSkill)
        description = "\n5.  \(type)  |  ⚔️ Arme : \(weapon.name) (-\(weapon.damages)hp)   | 🏥 Soins : + \(healSkill)hp"
    }
}

