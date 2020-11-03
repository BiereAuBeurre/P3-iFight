//  Player.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Player {
    
    static var indexCountHelper = 0
    //FIXME: déclarer en name: String puis rajouter dans l'init, trouver cmt l'appeler après par contre
    var name = String()
    var squad = [Character]()
    var killedEnnemy = [Character]()
    
    func isAllSquadAlive() -> Bool {
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
                    //FIXME: trouver une façon de supprimer cette ligne, voir au niveau de chooseNameOfCharacter()
                    magicien.characterName = characterName
                    squad.append(magicien)
                }
            case "2" :
                let chevalier = Chevalier()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(chevalier.type)") {
                    chevalier.characterName = characterName
                    squad.append(chevalier)
                }
            case "3" :
                let dragon = Dragon()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(dragon.type)") {
                    dragon.characterName = characterName
                    squad.append(dragon)
                }
            case "4" :
                let druide = Druide()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(druide.type)") {
                    druide.characterName = characterName
                    squad.append(druide)
                }
            case "5" :
                let sorcier = Sorcier()
                if let characterName = chooseNameOfCharacter(typeOfCharacter: "\(sorcier.type)") {
                    sorcier.characterName = characterName
                    squad.append(sorcier)
                }
            default:
                print("⛔️ Merci de taper un chiffre entre 1 et 5 pour chosir le personnage correspondant ⛔️")
            }
        }
    }
    
    func chooseNameOfCharacter(typeOfCharacter: String) -> String? {
        //FIXME: ici trouver comment intégrer directement le même characterName que le name de la class Character (remplacer name par characterName) car on est dans la class Player et qu'il y a déjà une propriété name, celle correspondant au player
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
            return characterName
        }
    }
    
    func attackEnnemyOrHealTeamMate(fightingCharacter: Character) {
        print("\(name) Quelle action veux-tu réaliser ? \n"
            + "\n1. Attaquer un ennemi ⚔️\n"
            + "\n2. Soigner un coéquipier 🏥\n")
        if let choice = readLine() {
            switch choice {
            case "1":
                // Si l'index est sur le player[0], attack ennemy à l'index 1, else fait l'inverse (si indexCountHelper != 0) ⬇️
                if Player.indexCountHelper == 0 {
                    whoToAttack(squadToAttack: game.players[1].squad, fightingCharacter: fightingCharacter)
                } else {
                    whoToAttack(squadToAttack: game.players[0].squad, fightingCharacter: fightingCharacter)
                }
                // FIXME: modifier pour un filter à la place ? du genre :
                // for player in players {
                //      while player.isAllSquadAlive == true {
                //  let opponent = players.filtrer { player.name != $0.name }
                //       }
                //  }
                // Puis indiquer comme squadToAttack: opponent
            case "2":
                whoToHeal(fightingCharacter: fightingCharacter)
            default:
                print ("⛔️ Merci de taper 1 ou 2 pour choisir l'action correspondante ⛔️\n")
                attackEnnemyOrHealTeamMate(fightingCharacter: fightingCharacter)
            }
        }
    }
    
    func pickFighter() {
        if isAllSquadAlive() {
            // Choix du character qui va combattre par le player dans son squad ⬇️
            print("\(name) Sélectionne le personnage que tu souhaites faire jouer pour le round \(Game.round+1) ⬇️\n")
            sleep(UInt32(1.0))
            for (index, character) in squad.enumerated() {
                if character.hp > 0 {
                    print("\(index+1). \(character.characterName) le \(character.type) ( ⚔︎ Arme : \(character.weapon.name) | ☠︎ Dégats : \(character.weapon.damages) | ❤︎ Soins : \(character.healSkill))")
                }
            }
            if let choice = readLine() {
                switch choice {
                case "1" where squad[0].hp > 0 :
                    choosenFighterAction(fighterNumber: 0)
                case "2" where squad[1].hp > 0  :
                    choosenFighterAction(fighterNumber: 1)
                case "3" where squad[2].hp > 0 :
                    choosenFighterAction(fighterNumber: 2)
                default :
                    print("⛔️ Merci de choisir un personnage de ton équipe en tapant le numéro correspondant à ton choix ⛔️\n")
                    pickFighter()
                }
            }
        }
    }
    
    //FIXME: Ajouter le filter dans choosenFighterAction() ? Puis indiquer l'opponent en valeur de squadToAttack simplement dans le case 1 de attackEnnemyOrHealTeamMate() ?! pour ensuite supprimer indexCountHelper, if et else du case 1 (et startFight() pour indexCountHelper)
    func choosenFighterAction(fighterNumber: Int) {
        print("Ok tu vas jouer avec \(squad[fighterNumber].characterName) le \(squad[fighterNumber].type)\n")
        let fightingCharacter = squad[fighterNumber]
        fightingCharacter.mayOpenChest()
        attackEnnemyOrHealTeamMate(fightingCharacter: squad[fighterNumber])
    }
    
    
    func whoToAttack(squadToAttack: [Character], fightingCharacter: Character) {
        print("\nOk \(name), quel ennemi veux tu attaquer ? 😈\n")
        for (index, character) in squadToAttack.enumerated() {
            if character.hp > 0 {
                print("\(index+1). \(character.characterName) le \(character.type) (\(character.hp)/\(character.maxHp))")
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
                whoToAttack(squadToAttack: squadToAttack, fightingCharacter: fightingCharacter)
            }
        }
    }
    
    func attacking(squadToAttack: [Character], squadMember: Int, fightingCharacter: Character) {
        if squad.indices.contains(squadMember) {
            let attackedCharacter = squadToAttack[squadMember]
            if squadToAttack[squadMember].hp <= fightingCharacter.weapon.damages {
                print("\nCe personnage a perdu ses \(attackedCharacter.hp) derniers points de vie 😢, il est mort et donc éliminé !\n")
                removeDeadCharacter(attackedCharacter: attackedCharacter)
                sleep(UInt32(2.0))
            } else {
                attackedCharacter.hp -= fightingCharacter.weapon.damages
                print("🤜💥 \(attackedCharacter.characterName) vient de perdre \(fightingCharacter.weapon.damages) hp, il lui reste \(attackedCharacter.hp)/ \(attackedCharacter.maxHp) 💔\n")
                sleep(UInt32(2.0))
            }
        }
    }
    
    func removeDeadCharacter( attackedCharacter: Character) {
        attackedCharacter.hp = 0
        killedEnnemy.append(attackedCharacter)
    }
    
    func healing (index: Int, healingCharacter: Character) {
        let hpDiff = squad[index].maxHp - squad[index].hp
        if squad[index].hp > 0 {
            if squad[index].hp == squad[index].maxHp {
                sleep(UInt32(1.0))
                print("⛔️ Tu ne peux pas soigner ce personnage, il a déjà tous ses points de vie 🦾 Choisi une autre action à réaliser pour ce tour !\n")
                attackEnnemyOrHealTeamMate(fightingCharacter: squad[index])
            } else if hpDiff < 10 {
                sleep(UInt32(1.0))
                squad[index].hp += hpDiff
                print("\(squad[index].characterName) récupère \(hpDiff) point(s) de vie, il a de nouveau 💯 points de vie 🔥\n")
            } else {
                sleep(UInt32(1.0))
                squad[index].hp += healingCharacter.healSkill
                print("\(squad[index].characterName) récupère \(healingCharacter.healSkill) points de vie, il a maintenant \(squad[index].hp)/\(squad[index].maxHp) 🦸🏿‍♂️\n")
            }
        }
    }
    
    func whoToHeal(fightingCharacter: Character) {
        print("Ok \(name), quel coéquipier veux-tu soigner ? 🤕 🩹\n")
        for (index, character) in squad.enumerated() {
            if squad[index].hp > 0 {
                print("\(index+1). Soigner \(character.characterName) le \(character.type) (\(character.hp)/\(character.maxHp))")
            }
        }
        if let choice = readLine() {
            let healingCharacter = fightingCharacter
            switch choice {
            case "1" where squad[0].hp > 0 :
                healing(index: 0, healingCharacter: healingCharacter)
            case "2" where squad[1].hp > 0 :
                healing(index: 1, healingCharacter: healingCharacter)
            case "3" where squad[2].hp > 0 :
                healing(index: 2, healingCharacter: healingCharacter)
            default: print("⛔️ Merci de choisir le numéro d'un des personnages disponible parmi la liste ⛔️\n")
            whoToHeal(fightingCharacter: fightingCharacter)
            }
        }
    }
    
    func showStatistic(index: Int) {
        //Si j'ai 3 killedEnnemy, j'ai gagné, si j'en ai moins, j'ai perdu
        if killedEnnemy.count == 3 {
            winnerStats(index: index)
        } else {
            looserStats(index: index)
        }
    }
    
    func winnerStats(index: Int) {
        print("\n🥳 \(name) tu as gagné après avoir tué toute l'équipe \(game.players[index].name) :")
        for ennemy in killedEnnemy {
            print("\n🌟 Nom : \(ennemy.characterName)"
                + "\n🆔 Type : \(ennemy.type)")
        }
        sleep(UInt32(1.0))
        print("\n💪 Voici le(s) survivant(s) de ton équipe :")
        for character in squad {
            if character.hp > 0 {
                print("\n🌟 Nom : \(character.characterName)"
                    + "\n🆔 Type : \(character.type)"
                    + "\n❤️ Points de vie : \(character.hp)/100\n")
            }
        }
    }
    
    func looserStats(index: Int) {
        print("\n👎 \(name) tu as perdu 😭 toute ton équipe nous a quitté... :\n")
        for character in squad {
            print("\n🌟 Nom : \(character.characterName)"
                + "\n🆔 Type : \(character.type)")
        }
        if killedEnnemy.count == 1 {
            sleep(UInt32(1.0))
            print("Tu as sauvé l'honneur face à \(game.players[index].name) en éliminant ⬇️\n"
                + "\n🌟 Nom : \(killedEnnemy[0].characterName)"
                + "\n🆔 Type : \(killedEnnemy[0].type)\n")
        }
        if killedEnnemy.count == 0 {
            sleep(UInt32(1.0))
            print("Tu ne t'es pas très bien défendu, tu n'as éliminé aucun de tes adversaires... 😐")
        } else if killedEnnemy.count == 2 {
            sleep(UInt32(1.0))
            print("\nDommage ! Tu es passé à ça 🤏 de la victoire en éliminant ⬇️\n"
                + "\n🌟 Nom : \(killedEnnemy[0].characterName)"
                + "\n🆔 Type : \(killedEnnemy[0].type)"
                + "\n\n＆\n"
                + "\n🌟 Nom : \(killedEnnemy[1].characterName)"
                + "\n🆔 Type : \(killedEnnemy[0].type)")
        }
    }
}
