//
//  Character.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Character {
    
    var hp = 100
    //FIXME: déclarer en name: String puis rajouter dans l'init, trouver cmt l'appeler après par contre car bloque au bout d'un moment characterName plus reconnu, doublon avec guard let ? créé nouvelle propriété du même nom ou lui assigne une valeur ?
    let name: String
    let maxHp = 100
    let minHp = 0
    static var names = [String]()
    let type: String
    var weapon: Weapon
    var description = ""
    let healSkill: Int
    
    init(weapon: Weapon, type: String, healSkill: Int, name: String) {
        self.weapon = weapon
        self.type = type
        self.healSkill = healSkill
        self.name = name
    }
    
    public func mayOpenChest() {
        let number = Int.random(in: 0...10)
        if number <= 1 {
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
            } else {
                print("➡️ Dommage...! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui ne met que \(specialWeapon.damages) de dégats")
            }
            weapon = specialWeapon
        }
    }
    
    public func presentation() {
        print("\n🌟 Nom : \(name)"
                + "\n🆔 Type : \(type)")
    }
}

//    func whoToAttack(squadToAttack: [Character], fightingCharacter: Character) {
//        print("\nOk \(name), quel ennemi veux tu attaquer ? 😈\n")
//        for (index, character) in squadToAttack.enumerated() {
//            if character.hp > 0 {
//                print("\(index+1). \(character.name) le \(character.type) (\(character.hp)/\(character.maxHp))")
//            }
//        }
//        if let choice = readLine() {
//            switch choice {
//            case "1" where squadToAttack[0].hp > 0 :
//                attacking(squadToAttack: squadToAttack, squadMember: 0, fightingCharacter: fightingCharacter)
//            case "2" where squadToAttack[1].hp > 0 :
//                attacking(squadToAttack: squadToAttack, squadMember: 1, fightingCharacter: fightingCharacter)
//            case "3" where squadToAttack[2].hp > 0 :
//                attacking(squadToAttack: squadToAttack, squadMember: 2, fightingCharacter: fightingCharacter)
//            default:
//                print("⛔️ Merci de choisir le numéro d'un des personnages de la liste ⛔️\n")
//                whoToAttack(squadToAttack: squadToAttack, fightingCharacter: fightingCharacter)
//            }
//        }
//    }
//
//    func removeDeadCharacter(attackedCharacter: Character) {
//       attackedCharacter.hp = 0
//       killedEnnemy.append(attackedCharacter)
//   }
//
//    public func attacking(squadToAttack: [Character], squadMember: Int, fightingCharacter: Character) {
//        if squad.indices.contains(squadMember) {
//            let attackedCharacter = squadToAttack[squadMember]
//            if squadToAttack[squadMember].hp <= fightingCharacter.weapon.damages {
//                print("\nCe personnage a perdu ses \(attackedCharacter.hp) derniers points de vie 😢, il est mort et donc éliminé !\n")
//                removeDeadCharacter(attackedCharacter: attackedCharacter)
//                sleep(UInt32(2.0))
//            } else {
//                attackedCharacter.hp -= fightingCharacter.weapon.damages
//                print("🤜💥 \(attackedCharacter.name) vient de perdre \(fightingCharacter.weapon.damages) hp, il lui reste \(attackedCharacter.hp)/ \(attackedCharacter.maxHp) 💔\n")
//                sleep(UInt32(2.0))
//            }
//        }
//    }
