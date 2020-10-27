//
//  Character.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Character {
    
    var hp = 100
    var name = String()
    let maxHp = 100
    let minHp = 0
    static var names =  [String]()
    let type: String
    var weapon: Weapon
    var description = ""

    init(weapon: Weapon, type: String) {
        self.weapon = weapon
        self.type = type
    }
    
    func chestSettings() {
        let number = Int.random(in: 0..<10)
        if number <= 1 {
            let arrow = Weapon(damages: 80, name: "Arc", healSkill: 10)
            let branch = Weapon(damages: 5, name: "Branche", healSkill: 60)
            let spear = Weapon(damages: 65, name: "Lance", healSkill: 15)
            let slingShot = Weapon(damages: 10, name: "Lance-pierres", healSkill: 65)
            let magicSword = Weapon(damages: 70, name: "Épée magique", healSkill: 8)
            let baseballBat = Weapon(damages: 15, name: "Bate de baseball", healSkill: 55)
            let chestWeapon = [arrow, branch, spear, slingShot, magicSword, baseballBat]
            print("BONUS 🎁 :\n")
            sleep(UInt32(1.0))
            print("Un coffre apparaît, voyons ce qu'il contient... 🧐")
            sleep(UInt32(1.0))
            print("\n⌛️ Nouvelle arme en cours de chargement...⏳\n")
            let specialWeapon = chestWeapon.randomElement()!
            if specialWeapon.damages > 50 {
                print("➡️ Bonne pioche ! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui met \(specialWeapon.damages) de dégats")
            } else if specialWeapon.damages < 30 {
                print("➡️ Dommage...! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui ne met que \(specialWeapon.damages) de dégats")
            } else {
                print("➡️ À toi d'aviser ! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui met \(specialWeapon.damages) de dégats")
            }
            weapon = specialWeapon
        }
    }
}
