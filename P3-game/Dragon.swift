//
//  Priest.swift
//  P3-game
//
//  Created by Manon Russo on 17/08/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Dragon: Character {
    // MARK: - Public properties
    
    init(name: String) {
        let weapon = FlameThrower()
        let type = "Dragon"
        let healSkill = 10
        let description = "\n3. \(type)    |  ⚔️ Arme : \(weapon.name) (-\(weapon.damages)hp)    | 🏥 Soins : + \(healSkill)hp"
        super.init(weapon: weapon, type: type, healSkill: healSkill, name: name, description: description)
    }
}
