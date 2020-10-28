//
//  Character.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

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
    let healSkill: Int

    init(weapon: Weapon, type: String, healSkill: Int) {
        self.weapon = weapon
        self.type = type
        self.healSkill = healSkill
    }
    
    func chestSettings() {
        let number = Int.random(in: 0...10)
        if number <= 3 {
            let arrow = Weapon(damages: 80, name: "Arc")
            let branch = Weapon(damages: 5, name: "Branche")
            let spear = Weapon(damages: 65, name: "Lance")
            let slingShot = Weapon(damages: 10, name: "Lance-pierres")
            let magicSword = Weapon(damages: 70, name: "Épée magique")
            let baseballBat = Weapon(damages: 15, name: "Bate de baseball")
            let chestWeapon = [arrow, branch, spear, slingShot, magicSword, baseballBat]
            print("BONUS 🎁 :\n")
            sleep(UInt32(1.0))
            print("Un coffre apparaît, voyons ce qu'il contient... 🧐")
            sleep(UInt32(1.0))
            print("\n⌛️ Nouvelle arme en cours de chargement...⏳\n")
            sleep(UInt32(1.0))
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
