//
//  Weapon.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Weapon {
    // MARK: - Internal properties
    var damages: Int
    var name: String
    init(damages: Int, name: String) {
        self.damages = damages
        self.name = name
    }
}
