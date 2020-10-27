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
        
    func areAllMembersSquadDead() -> Bool {
        let totalHpSquad = squad[0].hp + squad[1].hp + squad[2].hp
        return totalHpSquad > 0
    }
    
    func makeMySquad() {
        while squad.count < 3 {
            let playableCharacters = [Magicien(), Chevalier(), Dragon(), Druide(), Sorcier()]
            print("Choisis le personnages numéro \(squad.count+1): \n")
            for (characters) in playableCharacters {
                print("\(characters.description)")
            }
            let choice = readLine()
            switch choice {
            case "1" :
                let magicien = Magicien()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(magicien.type)") {
                    magicien.name = characterName
                    squad.append(magicien)
                }
            case "2" :
                let chevalier = Chevalier()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(chevalier.type)") {
                    chevalier.name = characterName
                    squad.append(chevalier)
                }
            case "3" :
                let dragon = Dragon()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(dragon.type)") {
                    dragon.name = characterName
                    squad.append(dragon)
                }
            case "4" :
                let druide = Druide()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(druide.type)") {
                    druide.name = characterName
                    squad.append(druide)
                }
            case "5" :
                let sorcier = Sorcier()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(sorcier.type)") {
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
    
    func attackEnnemyOrHealTeamMate(fightingCharacter: Character) {
        if areAllMembersSquadDead() {
            // Tant que le squad.count contient des character, continuer de lancer l'action fight, sinon afficher les stats ⬇️
            print("\(name) Quelle action veux-tu réaliser ? \n"
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
                    attackEnnemyOrHealTeamMate(fightingCharacter: fightingCharacter)
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
                    print("\(index+1). \(character.name) le \(character.type) ( ⚔︎ Arme : \(character.weapon.name) | ☠︎ Dégats : \(character.weapon.damages) | ❤︎ Soins : \(character.healSkill))")
                }
            }
            if let choice = readLine() {
                switch choice {
                case "1" where squad[0].hp > 0 :
                    choosenFighter(fighterNumber: 0)
                case "2" where squad[1].hp > 0  :
                    choosenFighter(fighterNumber: 1)
                case "3" where squad[2].hp > 0 :
                    choosenFighter(fighterNumber: 2)
                default :
                    print("⛔️ Merci de choisir un personnage de ton équipe en tapant le numéro correspondant à ton choix ⛔️\n")
                    pickFighter()
                }
            }
        }
    }
    
    func choosenFighter(fighterNumber: Int) {
        print("Ok tu vas jouer avec \(squad[fighterNumber].name) le \(squad[fighterNumber].type)\n")
        let fightingCharacter = squad[fighterNumber]
        fightingCharacter.chestSettings()
        attackEnnemyOrHealTeamMate(fightingCharacter: squad[fighterNumber])
    }
    
    func attackEnnemy(squadToAttack: [Character], fightingCharacter: Character) {
        print("\nOk \(name), quel ennemi veux tu attaquer ? 😈\n")
        for (index, character) in squadToAttack.enumerated() {
            if character.hp > 0 {
                print("\(index+1). \(character.name) le \(character.type) (\(character.hp)/\(character.maxHp))")
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
                print("\nCe personnage a perdu ses derniers \(attackedCharacter.hp) points de vie 😢, il est mort et donc éliminé !\n")
                removeDeadCharacter(attackedCharacter: attackedCharacter)
                sleep(UInt32(2.0))
            } else {
                attackedCharacter.hp -= fightingCharacter.weapon.damages
                print("🤜💥 \(attackedCharacter.name) vient de perdre \(fightingCharacter.weapon.damages) hp, il lui reste \(attackedCharacter.hp)/ \(attackedCharacter.maxHp) 💔\n")
                sleep(UInt32(2.0))
            }
        }
    }
    
    func removeDeadCharacter( attackedCharacter: Character) {
        attackedCharacter.hp = 0
        killedEnnemy.append(attackedCharacter)
    }
    
    func healing (index: Int) {
        let hpDiff = squad[index].maxHp - squad[index].hp
        if squad[index].hp > 0 {
            if squad[index].hp == squad[index].maxHp {
                sleep(UInt32(1.0))
                print("⛔️ Tu ne peux pas soigner ce personnage, il a déjà tous ses points de vie 🦾 Choisi une autre action à réaliser pour ce tour !\n")
                attackEnnemyOrHealTeamMate(fightingCharacter: squad[index])
            } else if hpDiff < 10 {
                sleep(UInt32(1.0))
                squad[index].hp += hpDiff
                print("\(squad[index].name) récupère \(hpDiff) point(s) de vie, il a de nouveau 💯 points de vie 🔥\n")
            } else {
                if let healingCharacter = healingCharacter {
                    sleep(UInt32(1.0))
                    squad[index].hp += healingCharacter.healSkill
                    print("\(squad[index].name) récupère \(healingCharacter.healSkill) points de vie, il a maintenant \(squad[index].hp)/\(squad[index].maxHp) 🦸🏿‍♂️\n")
                }
            }
        }
    }
    
    func healTeamMate(fightingCharacter: Character) {
        print("Ok \(name), quel coéquipier veux-tu soigner ? 🤕 🩹\n")
        for (index, character) in squad.enumerated() {
            if squad[index].hp > 0 {
                print("\(index+1). Soigner \(character.name) le \(character.type) (\(character.hp)/\(character.maxHp))")
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
            print("\n🥳 \(name) tu as gagné après avoir tué"
                + "\n🌟 Nom : \(killedEnnemy[0].name)"
                + "\n🆔 Type : \(killedEnnemy[0].type)\n"
                + "\n🌟 Nom : \(killedEnnemy[1].name)"
                + "\n🆔 Type :\(killedEnnemy[1].type)\n"
                + "\n🌟 Nom :  \(killedEnnemy[2].name)"
                + "\n🆔 Type : \(killedEnnemy[2].type)\n")
            sleep(UInt32(1.0))
            print("\n💪 Voici le(s) survivant(s) dans ton équipe :")
            if squad[0].hp > 0 {
                print("\n🌟 Nom : \(squad[0].name)"
                + "\n🆔 Type : \(squad[0].type)"
                + "\n❤️ Points de vie : \(squad[0].hp)/100 hp\n")
            }
            if squad[1].hp > 0 {
                print("\n🌟 Nom : \(squad[1].name)\n"
                    + "\n🆔 Type : \(squad[1].type)"
                    + "\n❤️ Points de vie : \(squad[1].hp)/100 hp\n")
            }
            if squad[2].hp > 0 {
                print("\n🌟 Nom : \(squad[2].name)\n"
                    + "\n🆔 Type : \(squad[2].type)"
                    + "\n❤️ Points de vie : \(squad[2].hp)/100 hp\n")            }
        } else {
            print("\n👎 \(name) tu as perdu 😭 toute ton équipe nous a quitté... :\n"
                + "\n🌟 Nom : \(squad[0].name)"
                + "\n🆔 Type : \(squad[0].type)"
                + "\n🌟 Nom : \(squad[1].name)"
                + "\n🆔 Type : \(squad[1].type)"
                + "\n🌟 Nom : \(squad[2].name)"
                + "\n🆔 Type : \(squad[2].type)")
            if killedEnnemy.count == 1 {
                sleep(UInt32(1.0))
                print("Tu as sauvé l'honneur face à \(game.players[index].name) en éliminant ⬇️\n"
                    + "\n🌟 Nom : \(killedEnnemy[0].name)"
                    + "\n🆔 Type : \(killedEnnemy[0].type)\n")
            }
            if killedEnnemy.count == 0 {
                sleep(UInt32(1.0))
                print("Tu ne t'es pas très bien défendu, tu n'as éliminé aucun de tes adversaires... 😐")
            } else if killedEnnemy.count == 2 {
                sleep(UInt32(1.0))
                print("Dommage ! Tu es passé à ça 🤏 de la victoire en éliminant\n"
                    + "\n🌟 Nom : \(killedEnnemy[0].name)"
                    + "\n🆔 Type : \(killedEnnemy[0].type)"
                    + "\n\n＆\n"
                    + "\n🌟 Nom : \(killedEnnemy[1].name)"
                    + "\n🆔 Type : \(killedEnnemy[0].type)")
            }
        }
    }
}
