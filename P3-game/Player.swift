//  Player.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Player {
    
    static var indexCountHelper = 0
    var name: String
    var squad = [Character]()
    var killedEnnemy = [Character]()
    init(name: String) {
        self.name = name
    }
    
    private enum CharactersList {
        case magicien, chevalier, dragon, druide, sorcier
    }
    
    private func madeCharacterInSquad(is character: CharactersList) {
        switch character {
        case .magicien:
            if let characterName = chooseNameOfCharacter(typeOfCharacter: "Magicien") {
                let magicien = Magicien(name: characterName)
                squad.append(magicien)
            }
        case .chevalier:
            if let characterName = chooseNameOfCharacter(typeOfCharacter: "Chevalier") {
                let chevalier = Chevalier(name: characterName)
                squad.append(chevalier)
            }
        case .dragon:
            if let characterName = chooseNameOfCharacter(typeOfCharacter: "Dragon") {
                let dragon = Dragon(name: characterName)
                squad.append(dragon)
            }
        case .druide:
            if let characterName = chooseNameOfCharacter(typeOfCharacter: "Druide") {
                let druide = Druide(name: characterName)
                squad.append(druide)
            }
        case .sorcier:
            if let characterName = chooseNameOfCharacter(typeOfCharacter: "Sorcier") {
                let sorcier = Sorcier(name: characterName)
                squad.append(sorcier)
            }
        }
    }
    
    public func makeMySquad() {
        while squad.count < 3 {
            //FIXME: trouver comment déclarer name avant chooseNameOfCharacter (définit dans les cases) dans playableCharacters
            let playableCharacters = [Magicien(name: ""), Chevalier(name: ""), Dragon(name: ""), Druide(name: ""), Sorcier(name: "")]
            print("Choisis le personnages numéro \(squad.count+1) : \n")
            for characters in playableCharacters {
                print(characters.description)
            }
            let choice = readLine()
            switch choice {
            case "1":
                madeCharacterInSquad(is: .magicien)
            case "2":
                madeCharacterInSquad(is: .chevalier)
            case "3":
                madeCharacterInSquad(is: .dragon)
            case "4":
                madeCharacterInSquad(is: .druide)
            case "5":
                madeCharacterInSquad(is: .sorcier)
            default:
                print("⛔️ Merci de taper un chiffre entre 1 et 5 pour chosir le personnage correspondant ⛔️")
            }
        }
    }
    
    /* private*/ func chooseNameOfCharacter(typeOfCharacter: String) -> String? {
        //FIXME: ici trouver comment intégrer directement le même characterName que le name de la class Character (remplacer name par characterName) car on est dans la class Player et qu'il y a déjà une propriété name, celle correspondant au player
        print ("\nComment veux tu l'appeler ?\n")
        // Indique que le characterName doit forcément contenir un readLine pour être enregsitré, sinon demander à nouveau à l'utilisateur ⬇️,
        guard let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty else {
            print("Merci de renseigner un nom pour ton personnage")
            return chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        }
        if Character.names.contains(userInput) {
            print("⛔️ Ce nom est déjà pris ⛔️\n")
            return chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        } else {
            Character.names.append(userInput)
            print("Très bien ! Ton \(typeOfCharacter) se nommera \(userInput)\n")
            return userInput
        }
    }
    
    public func isAllSquadAlive() -> Bool {
        let totalHpSquad = squad[0].hp + squad[1].hp + squad[2].hp
        return totalHpSquad > 0
    }
    
    // FIXME: AU NIVEAU DU CASE "1" de attackEnnemyOrHealTeamMate() ⬇️
    // Modifier pour un filter à la place ? du genre :
    // for player in players {
    //      while player.isAllSquadAlive == true {
    //  let opponent = players.filtrer { player.name != $0.name }
    //       }
    //  }
    // Puis indiquer comme squadToAttack: opponent
    
    private func attackEnnemyOrHealTeamMate(fightingCharacter: Character) {
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
            case "2":
                whoToHeal(fightingCharacter: fightingCharacter)
            default:
                print("⛔️ Merci de taper 1 ou 2 pour choisir l'action correspondante ⛔️\n")
                attackEnnemyOrHealTeamMate(fightingCharacter: fightingCharacter)
            }
        }
    }
    
    private func printAvailableFighter() {
        for (index, character) in squad.enumerated() {
            if character.hp > 0 {
                print("\(index+1). \(character.name) le \(character.type) ( ⚔︎ Arme : \(character.weapon.name) | ☠︎ Dégats : \(character.weapon.damages) | ❤︎ Soins : \(character.healSkill))")
            }
        }
    }
    
    public func pickFighter() {
        if isAllSquadAlive() {
            // Choix du character qui va combattre par le player dans son squad ⬇️
            print("\(name) Sélectionne le personnage que tu souhaites faire jouer pour le round \(Game.round+1) ⬇️\n")
            sleep(UInt32(1.0))
            printAvailableFighter()
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
    
    //FIXME: Ajouter le filter dans choosenFighterAction() ? Puis indiquer l'opponent en valeur de squadToAttack simplement dans le case 1 de attackEnnemyOrHealTeamMate() ?! pour ensuite supprimer indexCountHelper, if et else du case 1 (et startFight() pour indexCountHelper) ⬇️
    
    private func choosenFighterAction(fighterNumber: Int) {
        print("Ok tu vas jouer avec \(squad[fighterNumber].name) le \(squad[fighterNumber].type)\n")
        let fightingCharacter = squad[fighterNumber]
        fightingCharacter.mayOpenChest()
        attackEnnemyOrHealTeamMate(fightingCharacter: squad[fighterNumber])
    }
    
    private func whoToAttack(squadToAttack: [Character], fightingCharacter: Character) {
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
                whoToAttack(squadToAttack: squadToAttack, fightingCharacter: fightingCharacter)
            }
        }
    }
    
    private func attacking(squadToAttack: [Character], squadMember: Int, fightingCharacter: Character) {
        if squad.indices.contains(squadMember) {
            let attackedCharacter = squadToAttack[squadMember]
            if squadToAttack[squadMember].hp <= fightingCharacter.weapon.damages {
                print("\nCe personnage a perdu ses \(attackedCharacter.hp) derniers points de vie 😢, il est mort et donc éliminé !\n")
                removeDeadCharacter(attackedCharacter: attackedCharacter)
                sleep(UInt32(2.0))
            } else {
                attackedCharacter.hp -= fightingCharacter.weapon.damages
                print("🤜💥 \(attackedCharacter.name) vient de perdre \(fightingCharacter.weapon.damages) hp, il lui reste \(attackedCharacter.hp)/ \(attackedCharacter.maxHp) 💔\n")
                sleep(UInt32(2.0))
            }
        }
    }
    
    private func removeDeadCharacter(attackedCharacter: Character) {
        attackedCharacter.hp = 0
        killedEnnemy.append(attackedCharacter)
    }
    
    private func healing(index: Int, healingCharacter: Character) {
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
                sleep(UInt32(1.0))
                squad[index].hp += healingCharacter.healSkill
                print("\(squad[index].name) récupère \(healingCharacter.healSkill) points de vie, il a maintenant \(squad[index].hp)/\(squad[index].maxHp) 🦸🏿‍♂️\n")
            }
        }
    }
    
    private func whoToHeal(fightingCharacter: Character) {
        print("Ok \(name), quel coéquipier veux-tu soigner ? 🤕 🩹\n")
        for (index, character) in squad.enumerated() {
            if squad[index].hp > 0 {
                print("\(index+1). Soigner \(character.name) le \(character.type) (\(character.hp)/\(character.maxHp))")
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
    
    public func showStatistic(index: Int) {
        //Si j'ai 3 killedEnnemy, j'ai gagné, sinon j'ai perdu
        if killedEnnemy.count == 3 {
            winnerStats(index: index)
        } else {
            looserStats(index: index)
        }
    }
    
    public func winnerStats(index: Int) {
        print("\n🥳 \(name) tu as gagné après avoir tué toute l'équipe \(game.players[index].name) :")
        for ennemy in killedEnnemy {
            ennemy.presentation()
        }
        sleep(UInt32(1.0))
        print("\n💪 Voici le(s) survivant(s) de ton équipe :")
        for character in squad {
            if character.hp > 0 {
                character.presentation()
                print("❤️ Points de vie : \(character.hp)/100\n")
            }
        }
    }
    
    public func looserStats(index: Int) {
        print("\n👎 \(name) tu as perdu 😭 toute ton équipe nous a quitté... :\n")
        for character in squad {
            character.presentation()
        }
        if killedEnnemy.count == 1 {
            sleep(UInt32(1.0))
            print("\nTu as sauvé l'honneur face à \(game.players[index].name) en éliminant ⬇️")
            killedEnnemy[0].presentation()
        }
        if killedEnnemy.count == 0 {
            sleep(UInt32(1.0))
            print("Tu ne t'es pas très bien défendu, tu n'as éliminé aucun de tes adversaires... 😐")
        } else if killedEnnemy.count == 2 {
            sleep(UInt32(1.0))
            print("\nDommage ! Tu es passé à ça 🤏 de la victoire en éliminant ⬇️\n")
            killedEnnemy[0].presentation()
            killedEnnemy[1].presentation()
        }
    }
}
