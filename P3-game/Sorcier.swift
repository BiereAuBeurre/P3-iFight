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
//        let defaultCharacterDamages = 50
        super.init(weapon: weapon, type: type)
        description = "\n5. Le \(type), il attaque avec une \(weapon.name) qui provoque \(weapon.damages) dégats\n"
    }
}

