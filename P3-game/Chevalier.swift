//
//  Magus.swift
//  P3-game
//
//  Created by Manon Russo on 17/08/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Chevalier: Character {
    init() {
        let weapon = Sword()
        let defaultWeapon = Sword()
        let type = "Chevalier"
//        let defaultCharacterDamages = 30
        super.init(weapon: weapon, type: type, defaultWeapon: defaultWeapon, specialWeapon: weapon)
        description = "\n2. Le \(type), il attaque avec une \(weapon.name) qui provoque \(weapon.damages) dégats\n"
    }
}

