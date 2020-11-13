//
//  Character.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Character {
    
    var killedEnnemy = [Character]()
    var hp = 100
    let name: String
    let maxHp = 100
    private let minHp = 0
    static var names = [String]()
    let type: String
    var weapon: Weapon
    var description: String
    let healSkill: Int
    // passage de description dans l'init, n'est plus déclaré en description = ""
    init(weapon: Weapon, type: String, healSkill: Int, name: String, description: String) {
        self.weapon = weapon
        self.type = type
        self.healSkill = healSkill
        self.name = name
        self.description = description
    }
    
    func mayOpenChest() {
        let number = Int.random(in: 0...10)
        if number <= 1 {
            let arrow = Weapon(damages: 80, name: "Arc")
            let branch = Weapon(damages: 5, name: "Branche")
            let spear = Weapon(damages: 65, name: "Lance")
            let slingShot = Weapon(damages: 10, name: "Lance-pierres")
            let magicSword = Weapon(damages: 70, name: "Épée magique")
            let baseballBat = Weapon(damages: 15, name: "Bate de baseball")
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
    
    // EST-CE UTILE ?? ⬇️
    private func chestLoading() {
        print("BONUS 🎁 :\n")
        sleep(UInt32(1.0))
        print("Un coffre apparaît, voyons ce qu'il contient... 🧐")
        sleep(UInt32(1.0))
        print("\n⌛️ Nouvelle arme en cours de chargement...⏳\n")
        sleep(UInt32(1.0))
    }
    
    func presentation() {
        print("\n🌟 Nom : \(name)"
                + "\n🆔 Type : \(type)")
    }
    
    func healing(squadMember: Int, squadToHeal: [Character]) {
        let hpDiff = squadToHeal[squadMember].maxHp - squadToHeal[squadMember].hp
        if squadToHeal[squadMember].hp > 0 {
            if squadToHeal[squadMember].hp == squadToHeal[squadMember].maxHp {
                sleep(UInt32(1.0))
                print("⛔️ Tu ne peux pas soigner ce personnage, il a déjà tous ses points de vie 🦾 Choisi une autre action à réaliser pour ce tour !\n")
                //               attackEnnemyOrHealTeamMate(fightingCharacter: squadToHeal[squadMember])
                whoToHeal(squadToHeal: squadToHeal)
            } else if hpDiff < 10 {
                sleep(UInt32(1.0))
                squadToHeal[squadMember].hp += hpDiff
                print("\(squadToHeal[squadMember].name) récupère \(hpDiff) point(s) de vie, il a de nouveau 💯 points de vie 🔥\n")
            } else {
                sleep(UInt32(1.0))
                squadToHeal[squadMember].hp += healSkill
                print("\(squadToHeal[squadMember].name) récupère \(healSkill) points de vie, il a maintenant \(squadToHeal[squadMember].hp)/\(squadToHeal[squadMember].maxHp) 🦸🏿‍♂️\n")
            }
        }
    }
    
    func whoToHeal(squadToHeal: [Character]) {
        if let choice = readLine() {
            //                let healingCharacter = fightingCharacter
            switch choice {
            case "1" where squadToHeal[0].hp > 0 :
                healing(squadMember: 0, squadToHeal: squadToHeal)
            case "2" where squadToHeal[1].hp > 0 :
                healing(squadMember: 1, squadToHeal: squadToHeal)
            case "3" where squadToHeal[2].hp > 0 :
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
    
    private func attacking(squadToAttack: [Character], squadMember: Int) -> Character? {
        if squadToAttack.indices.contains(squadMember) {
            let attackedCharacter = squadToAttack[squadMember]
            if squadToAttack[squadMember].hp <= weapon.damages {
                print("\nCe personnage a perdu ses \(attackedCharacter.hp) derniers points de vie 😢, il est mort et donc éliminé !\n")
                attackedCharacter.hp = 0
                sleep(UInt32(2.0))
                return attackedCharacter
            } else {
                attackedCharacter.hp -= weapon.damages
                print("🤜💥 \(attackedCharacter.name) vient de perdre \(weapon.damages) hp, il lui reste \(attackedCharacter.hp)/ \(attackedCharacter.maxHp) 💔\n")
                sleep(UInt32(2.0))
                return nil
            }
        }
        return nil
    }
}

//    func isAlive() -> Bool {
//        return hp > 0
//    }
