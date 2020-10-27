//  Player.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Player {
    
    static var indexCountHelper = 0
    var name = String()
    var squad = [Character]()
    var killedEnnemy = [Character]()
    var healingCharacter: Character?
    let specialWeaponDamages = [80, 5, 65, 10, 70, 15]
    
    // ?? lazy var judicieux à utiliser pour aller code et ne pas avoir à init les valeurs ? je l'avais mis pour specialWeapon à un moment qui devait être init
    
    var specialWeapon = Int()
    
    func areAllMembersSquadDead() -> Bool {
        let totalHpSquad = squad[0].hp + squad[1].hp + squad[2].hp
        return totalHpSquad > 0
    }
    
    func makeMySquad() {
        while squad.count < 3 {
            let magicien = Magicien()
            let chevalier = Chevalier()
            let dragon = Dragon()
            let druide = Druide()
            let sorcier = Sorcier()
            
            print("Choisis le  personnage numero \(squad.count+1) :\n"
                + "\(magicien.description)"
                + "\(chevalier.description)"
                + "\(dragon.description)"
                + "\(druide.description)"
                + "\(sorcier.description)")
            let choice = readLine()
            switch choice {
            case "1" :
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(magicien.type)") {
                    let magicien = Magicien()
                    magicien.name = characterName
                    magicien.characterType = magicien.type
                    squad.append(magicien)
                }
            case "2" :
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(chevalier.type)") {
                    let chevalier = Chevalier()
                    chevalier.name = characterName
                    chevalier.characterType = chevalier.type
                    squad.append(chevalier)
                }
            case "3" :
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(dragon.type)") {
                    let dragon = Dragon()
                    dragon.name = characterName
                    dragon.characterType = dragon.type
                    squad.append(dragon)
                }
            case "4" :
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(druide.type)") {
                    let druide = Druide()
                    druide.name = characterName
                    druide.characterType = druide.type
                    squad.append(druide)
                }
            case "5" :
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(sorcier.type)") {
                    let sorcier = Sorcier()
                    sorcier.characterType = sorcier.type
                    sorcier.name = characterName
                    squad.append(sorcier)
                }
            default:
                print("⛔️ Merci de taper un chiffre entre 1 et 5 pour chosir le personnage correspondant ⛔️")
            }
        }
    }
    
    func chooseNameOfCharacter(typeOfCharacter: String) -> String? {
        print ("\nComment veux tu l'appeler ?\n")
        // Indique que le characterName doit forcément contenir un readLine pour être enregsitré, sinon demander à nouveau à l'utilisateur ⬇️,
        guard let characterName = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !characterName.isEmpty else {
            print("Merci de renseigner un nom pour ton personnage.")
            return chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        }
        if Character.names.contains(characterName) {
            print("⛔️ Ce nom est déjà pris ⛔️\n")
            return chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        } else {
            Character.names.append(characterName)
            print("Très bien ! Ton \(typeOfCharacter) se nommera \(characterName)\n")
            // Indique que le readLine correspondra au characterName du character sélectionné, on précise donc que le champ ne peut être vide et qu'il doit être différents des autres characterName déjà présents
            return characterName
        }
    }
    
    func fight(fightingCharacter: Character) {
        if areAllMembersSquadDead() {
            // Tant que le squad.count contient des character, continuer de lancer l'action fight, sinon afficher les stats ⬇️
            print("\(/*game.players[indexCountHelper].*/name) Quelle action veux-tu réaliser ? \n"
                + "\n1. Attaquer un ennemi ⚔️\n"
                + "\n2. Soigner un coéquipier 🏥\n")
            if let choice = readLine() {
                switch choice {
                case "1":
                    // Si l'index est sur le player[0], attack ennemy à l'index 1, else fait l'inverse (si indexCountHelper != 0) ⬇️
                    if Player.indexCountHelper == 0 {
                        attackEnnemy(squadToAttack: game.players[1].squad, fightingCharacter: fightingCharacter)
                    } else {
                        attackEnnemy(squadToAttack: game.players[0].squad, fightingCharacter: fightingCharacter)
                    }
                case "2":
                    healTeamMate(fightingCharacter: fightingCharacter)
                default:
                    print ("⛔️ Merci de taper 1 ou 2 pour choisir l'action correspondante ⛔️\n")
                    fight(fightingCharacter: fightingCharacter)
                }
            }
        }
    }
    
    func pickFighter() {
        let totalHpSquad = squad[0].hp + squad[1].hp + squad[2].hp
        if totalHpSquad > 0 {
            // Choix du character qui va combattre par le player dans son squad, on le fait pour les 2 persos grâce à startFight() ⬇️
            print("\(name) Sélectionne le personnage que tu souhaites faire jouer pour le round \(Game.round+1) ⬇️\n")
            sleep(UInt32(1.0))
            for (index, character) in squad.enumerated() {
                if character.hp > 0 {
                    print("\(index+1). \(character.name) le \(character.characterType) ( ⚔︎ Arme : \(character.defaultWeapon.name) | ☠︎ Dégats : \(character.defaultWeapon.damages) | ❤︎ Soins : \(character.defaultWeapon.healSkill))")
                }
            }
            if let choice = readLine() {
                switch choice {
                case "1" where squad[0].hp > 0 :
                    print("ok tu vas jouer avec \(squad[0].name) le \(squad[0].characterType)\n")
                    let fightingCharacter = squad[0]
                    fightingCharacter.chestSettings(fightingCharacter: squad[0])
                    fight(fightingCharacter: squad[0])
                    fightingCharacter.weapon = fightingCharacter.defaultWeapon
                case "2" where squad[1].hp > 0  :
                    print("ok tu vas jouer avec \(squad[1].name) le \(squad[1].characterType)\n")
                    let fightingCharacter = squad[1]
                    fightingCharacter.chestSettings(fightingCharacter: squad[1])
                    fight(fightingCharacter: squad[0])
                    fightingCharacter.weapon = fightingCharacter.defaultWeapon
                case "3" where squad[2].hp > 0 :
                    print("ok tu vas jouer avec \(squad[2].name) le \(squad[2].characterType)\n")
                    let fightingCharacter = squad[2]
                    fightingCharacter.chestSettings(fightingCharacter: squad[2])
                    fight(fightingCharacter: squad[2])
                    fightingCharacter.weapon = fightingCharacter.defaultWeapon
                default :
                    print("⛔️ Merci de choisir un personnage de ton équipe en tapant le numéro correspondant à ton choix ⛔️\n")
                    pickFighter()
                }
            }
        } else {
            // Print les stats de fin de partie, pour l'index 0 et 1 correspondant aux 2 players. ⬇️
            print ("\n************************************\n"
                + "\nAprès \(Game.round) rounds la partie est terminée, merci d'avoir joué ! 😊")
            // test ici
            game.players[0].showStatistic(index: 1)
            sleep(UInt32(1.0))
            game.players[1].showStatistic(index: 0)
        }
    }
    
    func attackEnnemy(squadToAttack: [Character], fightingCharacter: Character) {
        print("\nok \(name), quel ennemi veux tu attaquer ? ⚔️ 😈\n")
        for (index, character) in squadToAttack.enumerated() {
            if character.hp > 0 {
                print("\(index+1). \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp))")
            }
        }
        if let choice = readLine() {
            switch choice {
            case "1" where squadToAttack[0].hp > 0 :
                attacking(squadToAttack: squadToAttack, squadMember: 0, fightingCharacter: fightingCharacter)
            case "2" where squadToAttack[1].hp > 0 :
                attacking(squadToAttack: squadToAttack, squadMember: 1, fightingCharacter: fightingCharacter)
            case "3" where squadToAttack[2].hp > 0 :
                attacking(squadToAttack: squadToAttack, squadMember: 2, fightingCharacter: fightingCharacter)
            default:
                print("⛔️ Merci de choisir le numéro d'un des personnages de la liste ⛔️\n")
                attackEnnemy(squadToAttack: squadToAttack, fightingCharacter: fightingCharacter)
            }
        }
    }
    
    func attacking(squadToAttack: [Character], squadMember: Int, fightingCharacter: Character) {
        if squad.indices.contains(squadMember) {
            let attackedCharacter = squadToAttack[squadMember]

            if squadToAttack[squadMember].hp <= fightingCharacter.weapon.damages {
                removeDeadCharacter(attackedCharacter: attackedCharacter)
                print("\nCe personnage a perdu ses derniers points de vie 😢, il est mort et donc éliminé !\n")
                sleep(UInt32(2.0))
            } else {
                attackedCharacter.hp -= fightingCharacter.weapon.damages
                print("🤜💥 \(attackedCharacter.name) vient de perdre \(fightingCharacter.weapon.damages) hp, il lui reste \(attackedCharacter.hp)/ \(attackedCharacter.maxHp) 💔\n")
                sleep(UInt32(2.0))
            }
        }
    }
    
    func removeDeadCharacter( attackedCharacter: Character) {
        // Il y avait aussi le paramètre (squadMember: Int) que j'ai retiré car pas/plus utilisé 
        attackedCharacter.hp = 0
        killedEnnemy.append(attackedCharacter)
    }
    
    func healing (index: Int) {
        let hpDiff = squad[index].maxHp - squad[index].hp
        if squad[index].hp > 0 {
            if squad[index].hp == squad[index].maxHp {
                sleep(UInt32(1.0))
                print("⛔️ Tu ne peux pas soigner ce personnage, il a déjà tous ses points de vie 🦾 Choisi une autre action à réaliser pour ce tour !\n")
            } else if hpDiff < 10 {
                sleep(UInt32(1.0))
                squad[index].hp += hpDiff
                print("\(squad[index].name) récupère \(hpDiff) point(s) de vie, il a de nouveau 💯 points de vie 🔥\n")
            } else {
                if let healingCharacter = healingCharacter {
                    sleep(UInt32(1.0))
                    squad[index].hp += healingCharacter.weapon.healSkill
                    print("\(squad[index].name) récupère \(healingCharacter.weapon.healSkill) points de vie, il a maintenant \(squad[index].hp)/\(squad[index].maxHp) 🦸🏿‍♂️\n")
                }
            }
        }
    }
    
    func healTeamMate(fightingCharacter: Character) {
        print("Ok \(name), quel coéquipier veux-tu soigner ? 🤕 🩹\n")
        for (index, character) in squad.enumerated() {
            if squad[index].hp > 0 {
                print("\(index+1). Soigner \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp))")
            }
        }
        if let choice = readLine() {
            switch choice {
            case "1" where squad[0].hp > 0 :
                healingCharacter = fightingCharacter
                healing(index: 0)
            case "2" where squad[1].hp > 0 :
                healingCharacter = fightingCharacter
                healing(index: 1)
            case "3" where squad[2].hp > 0 :
                healingCharacter = fightingCharacter
                healing(index: 2)
            default: print("⛔️ Merci de choisir le numéro d'un des personnages disponible parmi la liste ⛔️\n")
            healTeamMate(fightingCharacter: fightingCharacter)
            }
        }
    }
    
    func showStatistic(index: Int) {
        // changer deadSquadMember pour killEnnemy : si j'ai 3 killedEnnemy, j'ai gagné, si j'en ai moins, j'ai perdu
        if killedEnnemy.count == 3 {
            print("\n🌟 \(name) tu as gagné après avoir tué \(killedEnnemy[0].name) le \(killedEnnemy[0].characterType), \(killedEnnemy[1].name) \(killedEnnemy[1].characterType) & \(killedEnnemy[2].name) le \(killedEnnemy[2].characterType)\n"
                + "\n💪 Voici le(s) survivant(s) dans ton équipe :\n")
            if squad[0].hp > 0 {
                print("\n▶️ \(squad[0].name) le \(squad[0].characterType) a \(squad[0].hp)/100 hp\n")
            }
            if squad[1].hp > 0 {
                print("\n▶️ \(squad[1].name) le \(squad[1].characterType) a \(squad[1].hp)/100 hp\n")
            }
            if squad[2].hp > 0 {
                print("\n▶️ \(squad[2].name) le \(squad[2].characterType) a \(squad[2].hp)/100 hp\n")
            }
        } else {
            print("\n👎 \(name) tu as perdu 😭 toute ton équipe nous a quitté... :\n"
                + "\n▶️ \(squad[0].name) le \(squad[0].characterType) a \(squad[0].hp)/100 hp\n"
                + "\n▶️ \(squad[1].name) le \(squad[1].characterType) a \(squad[1].hp)/100 hp\n"
                + "\n▶️ \(squad[2].name) le \(squad[2].characterType) a \(squad[2].hp)/100 hp\n")
            if killedEnnemy.count == 1 {
                print("Tu as sauvé l'honneur face à \(game.players[index].name) en éliminant \(killedEnnemy[0].name) le \(killedEnnemy[0].characterType) 🤷‍♂️")
            }
            if killedEnnemy.count == 0 {
                print("Tu ne t'es pas très bien défendu, tu n'as éliminé aucun de tes adversaires... 😐")
            } else if killedEnnemy.count == 2 {
                print("Dommage ! Tu es passé à ça 🤏 de la victoire en éliminant \(killedEnnemy[0].name) \(killedEnnemy[0].characterType) et \(killedEnnemy[1].name) le \(killedEnnemy[0].characterType)")
            }
        }
    }
}
