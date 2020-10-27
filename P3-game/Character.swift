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
    var characterType = String()
    let maxHp = 100
    let minHp = 0
    static var names =  [String]()
    let type: String
    var weapon: Weapon
    var description = ""
    let specialWeaponDamages = [80, 5, 65, 10, 70, 15]
//    var specialWeapon = Int()
    let arrow = Weapon(damages: 80, name: "Arc", healSkill: 0)
    let branch = Weapon(damages: 5, name: "Branche", healSkill: 0)
    let spear = Weapon(damages: 65, name: "Lance", healSkill: 0)
    let slingShot = Weapon(damages: 10, name: "Lance-pierres", healSkill: 0)
    let magicSword = Weapon(damages: 70, name: "Épée magique", healSkill: 0)
    let baseballBat = Weapon(damages: 15, name: "Bate de baseball", healSkill: 0)
    let defaultWeapon: Weapon
    
    var chestWeapon = [Weapon]()
    var specialWeapon: Weapon
    
    init(weapon: Weapon, type: String, defaultWeapon: Weapon, specialWeapon: Weapon) {
        self.weapon = weapon
        self.type = type
        self.defaultWeapon = defaultWeapon
        self.specialWeapon = specialWeapon
    }
    
    func chestSettings(fightingCharacter: Character) -> Weapon {
        let number = Int.random(in: 0..<10)
        if number <= 9 {
            fightingCharacter.changeWeaponDamages(fightingCharacter: fightingCharacter)
            chestChoice(fightingCharacter: fightingCharacter)
        }
        return fightingCharacter.weapon
    }
    
    
    func changeWeaponDamages(fightingCharacter: Character) {
        chestWeapon = [arrow, branch, spear, slingShot, magicSword, baseballBat]
        print("BONUS 🎁 :\n")
        sleep(UInt32(1.0))
        print("Un coffre apparaît, voyons ce qu'il contient... 🧐")
        sleep(UInt32(1.0))
        print("\n⌛️ Nouvelle arme en cours de chargement...⏳\n")
        specialWeapon = chestWeapon.randomElement()!
        fightingCharacter.weapon = specialWeapon
        if specialWeapon.damages > 50 {
            print("➡️ Bonne pioche ! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui met \(specialWeapon.damages) de dégats")
        } else if specialWeapon.damages < 30 {
            print("➡️ Dommage...! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui ne met que \(specialWeapon.damages) de dégats")
        } else {
            print("➡️ À toi d'aviser ! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui met \(specialWeapon.damages) de dégats")
        }
    }
    
//    func changeWeaponDamages(fightingCharacter: Character) -> Int {
//
//        specialWeapon = specialWeaponDamages.randomElement()!
//        chestWeapon = [arrow, branch, spear, slingShot, magicSword, baseballBat]
//        specialWeapon2 = chestWeapon.randomElement()!
//
//        print("BONUS 🎁 :\n")
//        sleep(UInt32(1.0))
//        print("Un coffre apparaît, voyons ce qu'il contient... 🧐")
//        sleep(UInt32(1.0))
//        print("\n⌛️ Nouvelle arme en cours de chargement...⏳\n")
//        sleep(UInt32(2.0))
//        if specialWeapon2 == arrow {
//            fightingCharacter.weapon = arrow
//            print("➡️ Bonne pioche ! Le coffre bonus te délivre un Arc qui a 80 de dégats 🏹")
//        } else if specialWeapon == 5 {
//           fightingCharacter.weapon = branch
//            print("➡️ Dommage... ! Ton coffre contenait une branche 🎋, elle ne met que 5 de dégats")
//        } else if specialWeapon == 65 {
//            fightingCharacter.weapon = spear
//            print("➡️ Super ! Tu débloques une lance qui peut mettre 65 dégats à ton ennemi !")
//        } else if specialWeapon == 10 {
//            fightingCharacter.weapon = slingShot
//            print("➡️ Aïe... tu ne pourras retirer que 10 points de vie à ton adversaire avec ce lance-pierres 💫 ...!")
//        } else if specialWeapon == 70 {
//            fightingCharacter.weapon = magicSword
//            print("➡️ Tu débloques une épée magique ⚔️ qui inflige 70 de dégats. Bien joué !")
//        } else if specialWeapon == 15 {
//            fightingCharacter.weapon = baseballBat
//            print("➡️ Cette bate ne met que - 15 hp à l'adversaire 🏏")
//        }
//        return specialWeapon
//    }
    
    func chestChoice(fightingCharacter: Character) {
        print("Que veux tu faire ?\n"
            + "\n1. Garder mon arme (\(defaultWeapon.name), dégats : \(defaultWeapon.damages))\n"
            + "\n2. utiliser l'arme du coffre (dégâts :\(specialWeapon.damages))\n")
        let userInput = readLine()
        let trimmedUserInput = userInput?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let choice = trimmedUserInput {
            switch choice {
            case "1" :
                fightingCharacter.weapon = defaultWeapon
                print("ok, tu garde l'arme de base")
            case "2" :
                fightingCharacter.weapon = specialWeapon
                print("très bien, tu sera armé de l'arme suivante pour ce tour : \(specialWeapon.name)")
            default:
                print("⛔️ Merci de taper 1 ou 2 ! ⛔️")
                chestChoice(fightingCharacter: fightingCharacter)
            }
        }
    }
}
