//  Player.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Player {
    // MARK: - Internal properties
    var name: String
    var squad = [Character]()

    init(name: String) {
        self.name = name
    }
    
    // MARK: - Private properties
    private var killedEnemy = [Character]()
    
    // MARK: - Internal methods
    func makeMySquad() {
        while squad.count < 3 {
            /// Creating an array of the different playable characters to print each of their description (in l28) in order to be chosen by the player. Thanks to the while condition, it'll be repeated until the squad.count is equal to 3.
            let playableCharacters = [Magicien(name: ""), Chevalier(name: ""), Dragon(name: ""), Druide(name: ""), Sorcier(name: "")]
            print("Choisis le personnages numéro \(squad.count+1) : \n")
            for characters in playableCharacters {
                print(characters.description)
            }
            let choice = readLine()
            switch choice {
            /// Each case matches with the selected character to :
            ///     - ad as character name the result of chooseNameOfCharacter() (matching the rawValue in the enum as the parameter typeOfCharacter)
            ///     - make an instance of the selected character with the characterName as the parameter name
            ///     - and then adding the selected character to the squad of the currrent player.
            case "1" :
                if let characterName = chooseNameOfCharacter(typeOfCharacter: .magicien) {
                    let magicien = Magicien(name: characterName)
                    squad.append(magicien)
                }
            case "2":
                if let characterName = chooseNameOfCharacter(typeOfCharacter: .chevalier) {
                    let chevalier = Chevalier(name: characterName)
                    squad.append(chevalier)
                }
            case "3":
                if let characterName = chooseNameOfCharacter(typeOfCharacter: .dragon) {
                    let dragon = Dragon(name: characterName)
                    squad.append(dragon)
                }
            case "4":
                if let characterName = chooseNameOfCharacter(typeOfCharacter: .druide) {
                    let druide = Druide(name: characterName)
                    squad.append(druide)
                }
            case "5":
                if let characterName = chooseNameOfCharacter(typeOfCharacter: .sorcier) {
                    let sorcier = Sorcier(name: characterName)
                    squad.append(sorcier)
                }
            default:
                print("⛔️ Merci de taper un chiffre entre 1 et 5 pour chosir le personnage correspondant ⛔️")
            }
        }
    }
    
    func isAllSquadAlive() -> Bool {
        /// Check if there's at least one character alive in the squad.
        return squad[0].hp + squad[1].hp + squad[2].hp > 0
    }
    
    func pickFighterAndAction(squadToAttack: [Character]) {
        if isAllSquadAlive() {
            /// The player pick the character of his choice (from his own squad) to play with for this round.
            print("\(name) Sélectionne le personnage que tu souhaites faire jouer pour le round \(Game.round+1) ⬇️\n")
            sleep(UInt32(1.0))
            printAvailableFighter(squad: squad)
            if let choice = readLine() {
                switch choice {
                case "1" where squad[0].hp > 0 :
                    choosenFighterAction(fighterNumber: 0, squadToAttack: squadToAttack)
                case "2" where squad[1].hp > 0  :
                    choosenFighterAction(fighterNumber: 1, squadToAttack: squadToAttack)
                case "3" where squad[2].hp > 0 :
                    choosenFighterAction(fighterNumber: 2, squadToAttack: squadToAttack)
                default :
                    print("⛔️ Merci de choisir un personnage de ton équipe en tapant le numéro correspondant à ton choix ⛔️\n")
                    pickFighterAndAction(squadToAttack: squadToAttack)
                }
            }
        }
    }
    
    func showStatistic(opponent: Player) {
        /// If I kill 3 enemies I'm the winner, else I'm the looser.
        if killedEnemy.count == 3 {
            winnerStats(opponent: opponent)
        } else {
            looserStats(opponent: opponent)
        }
    }
    // MARK: - Private methods
    private enum CharactersList: String {
        case magicien = "Magicien"
        case chevalier = "Chevalier"
        case dragon = "Dragon"
        case druide = "Druide"
        case sorcier = "Sorcier"
    }

    private func chooseNameOfCharacter(typeOfCharacter: CharactersList) -> String? {
        print ("\nComment veux tu l'appeler ?\n")
        /// Indicate that the userInput can't accept a readLine() that is empty or nil. If it is, it'll be asked again to the user until he gives a valid name.
        guard let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty else {
            print("Merci de renseigner un nom pour ton personnage")
            return chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        }
        if Character.names.contains(userInput) {
            print("⛔️ Ce nom est déjà pris ⛔️\n")
            return chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        } else {
            Character.names.append(userInput)
            print("Très bien ! Ton \(typeOfCharacter.rawValue) se nommera \(userInput)\n")
            return userInput
        }
    }
    
    private func attackEnemyOrHealTeamMate(fightingCharacter: Character, squadToAttack: [Character])  {
        print("\(name) Quelle action veux-tu réaliser ? \n"
                + "\n1. Attaquer un ennemi ⚔️\n"
                + "\n2. Soigner un coéquipier 🏥\n")
        if let choice = readLine() {
            switch choice {
            case "1" :
                attackEnemy(fightingCharacter: fightingCharacter, squadToAttack: squadToAttack)
            case "2"  :
                /// Checking if  the squad is healable (by checking each character's hp). if isHealable is false, switch to attackEnemy.
                var isHealable = false
                for character in squad where character.isHealable() {
                    isHealable = true
                    healTeamMate(fightingCharacter: fightingCharacter)
                    break
                }
                if isHealable == false {
                    print("⛔️ Il n'y a personne à soigner dans ton équipe, il faut forcément que tu attaques un ennemi pour ce tour ! ⛔️\n")
                    sleep(UInt32(1.0))
                    attackEnemy(fightingCharacter: fightingCharacter, squadToAttack: squadToAttack)
                }
            default:
                print("⛔️ Merci de taper 1 ou 2 pour choisir l'action correspondante ⛔️\n")
                attackEnemyOrHealTeamMate(fightingCharacter: fightingCharacter, squadToAttack: squadToAttack)
            }
        }
    }
    
    private func healTeamMate(fightingCharacter: Character) {
        print("\(name), qui veux-tu soigner ? 🤕 🩹\n")
        for (index, character) in squad.enumerated() {
            if character.isHealable() {
                print("\(index+1). \(character.name) le \(character.type) (♥︎ HP : \(character.hp)/\(character.maxHp) | ⚔︎ Arme : \(character.weapon.name) | ☠︎ Dégats : \(character.weapon.damages) | ✙ Soins : \(character.healSkill))")
            }
        }
        fightingCharacter.whoToHeal(squadToHeal: squad)
        sleep(UInt32(1.0))
    }
    
    private func printAvailableFighter(squad: [Character]) {
        for (index, character) in squad.enumerated() {
            if character.hp > 0 {
                print("\(index+1). \(character.name) le \(character.type) (♥︎ HP : \(character.hp)/\(character.maxHp) | ⚔︎ Arme : \(character.weapon.name) | ☠︎ Dégats : \(character.weapon.damages) | ✙ Soins : \(character.healSkill))")
            }
        }
    }
    
    private func attackEnemy(fightingCharacter: Character, squadToAttack: [Character]) {
        print("\(name), quel ennemi veux-tu attaquer ? 😈\n")
        printAvailableFighter(squad: squadToAttack)
        if let character = fightingCharacter.whoToAttack(squadToAttack: squadToAttack) {
            /// The above let character is define by the attacking method (called in whoToAttack), which returns an attackedCharacter in the case this one hp's turn to 0. In that case, he's added to the array killedEnemy which'll be used to define the winner and loser of the game. If he lives, he'll just loose some hp from the enemy's weapon.
            killedEnemy.append(character)
        }
    }
    
    private func choosenFighterAction(fighterNumber: Int, squadToAttack: [Character]) {
        print("Ok tu vas jouer avec \(squad[fighterNumber].name) le \(squad[fighterNumber].type)\n")
        let fightingCharacter = squad[fighterNumber]
        fightingCharacter.mayOpenChest()
        attackEnemyOrHealTeamMate(fightingCharacter: fightingCharacter, squadToAttack: squadToAttack)
    }
    
    private func winnerStats(opponent: Player) {
        print("\n🥳 \(name) tu as gagné après avoir tué toute l'équipe \(opponent.name) :")
        for enemy in killedEnemy {
            enemy.presentation()
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
    
    private func looserStats(opponent: Player) {
        print("\n👎 \(name) tu as perdu 😭 toute ton équipe nous a quitté... :\n")
        for character in squad {
            character.presentation()
        }
        if killedEnemy.count == 1 {
            sleep(UInt32(1.0))
            print("\nTu as sauvé l'honneur face à \(opponent.name) en éliminant ⬇️")
            killedEnemy[0].presentation()
        }
        if killedEnemy.count == 0 {
            sleep(UInt32(1.0))
            print("Tu ne t'es pas très bien défendu, tu n'as éliminé aucun de tes adversaires... 😐")
        } else if killedEnemy.count == 2 {
            sleep(UInt32(1.0))
            print("\nDommage ! Tu es passé à ça 🤏 de la victoire en éliminant ⬇️\n")
            killedEnemy[0].presentation()
            killedEnemy[1].presentation()
        }
    }
    
    func isEqualTo(name: String) -> Bool {
        /// Check if the name of the players[1] is equal to the name of players[0] (used only for the players[1] because players[0] can choose anythinng since there's no other playerName to compare with)
        return self.name == name
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
