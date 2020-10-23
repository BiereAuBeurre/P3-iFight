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
    let defaultCharacterDamages: Int
    let type: String
    var weapon: Weapon
    var description = ""
    let specialWeaponDamages = [80, 5, 65, 10, 70, 15]
    var specialWeapon = Int()
    
    init(weapon: Weapon, type: String, defaultCharacterDamages: Int) {
        self.weapon = weapon
        self.type = type
        self.defaultCharacterDamages = defaultCharacterDamages
    }
    
    func chestSettings(fightingCharacter: Character) -> Int {
        let number = Int.random(in: 0..<10)
        if number <= 3 {
            weapon.damages = changeWeaponDamages()
            chestChoice(fightingCharacter: fightingCharacter)
        }
        return weapon.damages
    }
    
    func changeWeaponDamages() -> Int {
        specialWeapon = specialWeaponDamages.randomElement()!
        print("BONUS 🎁 :\n")
        sleep(UInt32(1.0))
        print("Un coffre apparaît, voyons ce qu'il contient... 🧐")
        sleep(UInt32(1.0))
        print("\n⌛️ Nouvelle arme en cours de chargement...⏳\n")
        sleep(UInt32(2.0))
        if specialWeapon == 80 {
            print("➡️ Bonne pioche ! Le coffre bonus te délivre un Arc qui a 80 de dégats 🏹")
        } else if specialWeapon == 5 {
            print("➡️ Dommage... ! Ton coffre contenait une branche 🎋, elle ne met que 5 de dégats")
        } else if specialWeapon == 65 {
            print("➡️ Super ! Tu débloques une lance qui peut mettre 65 dégats à ton ennemi !")
        } else if specialWeapon == 10 {
            print("➡️ Aïe... tu ne pourras retirer que 10 points de vie à ton adversaire avec ce lance-pierres 💫 ...!")
        } else if specialWeapon == 70 {
            print("➡️ Tu débloques une épée magique ⚔️ qui inflige 70 de dégats. Bien joué !")
        } else if specialWeapon == 15 {
            print("➡️ Cette bate ne met que - 15 hp à l'adversaire 🏏")
        }
        return specialWeapon
    }
    
    func chestChoice(fightingCharacter: Character) {
        print("Que veux tu faire ?\n"
            + "\n1. Garder mon arme (\(weapon.name), dégats : \(defaultCharacterDamages))\n"
            + "\n2. utiliser l'arme du coffre (dégâts :\(specialWeapon))\n")
        let userInput = readLine()
        let trimmedUserInput = userInput?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let choice = trimmedUserInput {
            switch choice {
            case "1" :
                weapon.damages = defaultCharacterDamages
            case "2" :
                weapon.damages = specialWeapon
            default:
                print("⛔️ Merci de taper 1 ou 2 ! ⛔️")
                chestChoice(fightingCharacter: fightingCharacter)
            }
        }
    }
}
