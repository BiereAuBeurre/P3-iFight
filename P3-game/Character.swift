//
//  Character.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Character {
    // MARK: - Internal properties
    var hp = 100
    var name: String
    let maxHp = 100
    static var names = [String]()
    let type: String
    var weapon: Weapon
    var description: String
    let healSkill: Int
    
    init(weapon: Weapon, type: String, healSkill: Int, name: String, description: String) {
        self.weapon = weapon
        self.type = type
        self.healSkill = healSkill
        self.name = name
        self.description = description
    }
    
    // MARK: - Internal methods
    func mayOpenChest() {
        let number = Int.random(in: 0...10)
        if number <= 1 {
            let arrow = Weapon(damages: 80, name: "Arc")
            let branch = Weapon(damages: 5, name: "Branche")
            let spear = Weapon(damages: 65, name: "Lance")
            let slingShot = Weapon(damages: 10, name: "Lance-pierres")
            let magicSword = Weapon(damages: 70, name: "Épée magique")
            let baseballBat = Weapon(damages: 15, name: "Bate de baseball")
            /// Creating a chestWeapon with all the new weapon and then pick one random if the result of int.random as the value of let number is between 0 and five. If it is, switch the newWeapon as a weapon to the character.
            let chestWeapon = [arrow, branch, spear, slingShot, magicSword, baseballBat]
            chestLoading()
            let specialWeapon = chestWeapon.randomElement()!
            if specialWeapon.damages > 50 {
                print("➡️ Bonne pioche ! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui met \(specialWeapon.damages) de dégats")
            } else {
                print("➡️ Dommage...! Le coffre bonus te délivre l'arme spécial \(specialWeapon.name) qui ne met que \(specialWeapon.damages) de dégats")
            }
            weapon = specialWeapon
        }
    }
    
    func presentation() {
        print("\n🌟 Nom : \(name)"
                + "\n🆔 Type : \(type)")
    }
    
    func isHealable() -> Bool {
        /// Checking if a character is healable by having less than maxHp and more than 0 hp (you can't turn back to life a dead character).
        return hp > 0 && hp < maxHp
    }
    
    func whoToHeal(squadToHeal: [Character]) {
        if let choice = readLine() {
            switch choice {
            case "1" where squadToHeal[0].hp < 100 && squadToHeal[0].hp > 0 :
                healing(squadMember: 0, squadToHeal: squadToHeal)
            case "2" where squadToHeal[1].hp < 100 && squadToHeal[1].hp > 0 :
                healing(squadMember: 1, squadToHeal: squadToHeal)
            case "3" where squadToHeal[2].hp < 100 && squadToHeal[2].hp > 0 :
                healing(squadMember: 2, squadToHeal: squadToHeal)
            default: print("⛔️ Merci de choisir le numéro d'un des personnages disponible parmi la liste ⛔️\n")
                whoToHeal(squadToHeal: squadToHeal)
            }
        }
    }
    
    func whoToAttack(squadToAttack: [Character]) -> Character? {
        if let choice = readLine() {
            switch choice {
            case "1" where squadToAttack[0].hp > 0 :
                return attacking(squadToAttack: squadToAttack, squadMember: 0)
            case "2" where squadToAttack[1].hp > 0 :
                return attacking(squadToAttack: squadToAttack, squadMember: 1)
            case "3" where squadToAttack[2].hp > 0 :
                return attacking(squadToAttack: squadToAttack, squadMember: 2)
            default:
                print("⛔️ Merci de choisir le numéro d'un des personnages de la liste ⛔️\n")
                return whoToAttack(squadToAttack: squadToAttack)
            }
        }
        return nil
    }
    
    // MARK: - Private methods
    private func chestLoading() {
        print("BONUS 🎁 :\n")
        sleep(UInt32(1.0))
        print("Un coffre apparaît, voyons ce qu'il contient... 🧐")
        sleep(UInt32(1.0))
        print("\n⌛️ Nouvelle arme en cours de chargement...⏳\n")
        sleep(UInt32(1.0))
    }
    
    private func healing(squadMember: Int, squadToHeal: [Character]) {
        let healedCharacter = squadToHeal[squadMember]
        let hpDiff = healedCharacter.maxHp - healedCharacter.hp
        if healedCharacter.hp > 0 {
            sleep(UInt32(1.0))
            let hp = hpDiff <= healSkill ? hpDiff : healSkill
            healedCharacter.hp += hp
            if hpDiff <= healSkill {
                print("\(healedCharacter.name) récupère \(hpDiff) point(s) de vie, il a de nouveau 💯 points de vie 🔥\n")
            } else {
                print("\(healedCharacter.name) récupère \(healSkill) points de vie, il a maintenant \(healedCharacter.hp)/\(healedCharacter.maxHp) 🦸🏿‍♂️\n")
            }
        }
    }
    
    private func attacking(squadToAttack: [Character], squadMember: Int) -> Character? {
        if squadToAttack.indices.contains(squadMember) {
            let attackedCharacter = squadToAttack[squadMember]
            /// If the attackedCharacter's hp is lower or equal to the enemy's weapon damages, is hp'll turn to 0 (so hp will  never have a negative value).
            if attackedCharacter.hp <= weapon.damages {
                print("\n\(attackedCharacter.name) a perdu ses \(attackedCharacter.hp) derniers points de vie 😢, il est mort et donc éliminé !\n")
                attackedCharacter.hp = 0
                return attackedCharacter
            } else {
                attackedCharacter.hp -= weapon.damages
                print("🤜💥 \(attackedCharacter.name) vient de perdre \(weapon.damages) hp, il lui reste \(attackedCharacter.hp)/ \(attackedCharacter.maxHp) 💔\n")
                return nil
            }
        }
        sleep(UInt32(2.0))
        return nil
    }
}

