//
//  Priest.swift
//  P3-game
//
//  Created by Manon Russo on 17/08/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Dragon: Character {
    init() {
        let weapon = FlameThrower()
        let defaultWeapon = FlameThrower()
        let type = "Dragon"
//        let defaultCharacterDamages = 60
        super.init(weapon: weapon, type: type, defaultWeapon: defaultWeapon, specialWeapon: weapon)
        description = "\n3. Le \(type), il attaque avec une \(weapon.name) qui provoque \(weapon.damages) dégats\n"
    }
}
