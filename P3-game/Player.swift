//  Player.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Player {

    var name = String()
    var squad = [Character]()
    
    func makeMySquad() {
        while squad.count < 3 {
            let character = Character()
            squad.append(character)
            
            print("Choisis le  personnage numero \(squad.count)"
                + "\n1. Magicien"
                + "\n2. Chevalier"
                + "\n3. Dragon"
                + "\n4. Druide"
                + "\n5. Sorcier")
            
            let userInput = readLine()
            let trimmedUserInput = userInput?.trimmingCharacters(in: .whitespaces)
            if let choice = trimmedUserInput {
                
                switch choice {
                case "1" :
                    chooseNameOfCharacter(typeOfCharacter: "Magicien")
                    character.characterType = "Magicien"
                case "2" :
                    chooseNameOfCharacter(typeOfCharacter: "Chevalier")
                    character.characterType = "Chevalier"
                case "3" :
                    chooseNameOfCharacter(typeOfCharacter: "Dragon")
                    character.characterType = "Dragon"
                case "4" :
                    chooseNameOfCharacter(typeOfCharacter: "Druide")
                    character.characterType = "Druide"
                case "5" :
                    chooseNameOfCharacter(typeOfCharacter: "Sorcier")
                    character.characterType = "Sorcier"
                default: print("Merci de taper un chiffre entre 1 et 5 pour chosir le personnage correspondant")
                }
            }
        }
    }
    
//    FIXME: Rajouter la fonction trim() pour le choix du nom des persos de l'équipe
    
    func chooseNameOfCharacter(typeOfCharacter: String) {
        print("Comment veux tu l'appeler ?")
        let userInput = readLine()
        if Character.charactersNames.contains(userInput!) {
            print("Ce nom n'est pas valide ou déjà pris.")
            chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        } else {
            squad[squad.count-1].characterName = userInput!
            Character.charactersNames.append(userInput!)
            print("Très bien ! Ton \(typeOfCharacter) se nommera \(userInput!)")
        }
    }
    
    func pickFighter() {
        // Choix du character qui va combattre par le player dans son squad, on le fait pour les 2 persos grâce à startFight()
        print("\(name) Sélectionne le personnage que tu souhaites faire combattre :"
                + "\n1. \(squad[0].characterName) le \(squad[0].characterType)"
                + "\n2. \(squad[1].characterName) le \(squad[1].characterType)"
                + "\n3. \(squad[2].characterName) le \(squad[2].characterType)")
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    print("ok tu vas combattre avec \(squad[0].characterName) le \(squad[0].characterType)")
                case "2":
                    print("ok tu vas combattre avec \(squad[1].characterName) le \(squad[1].characterType)")
                case "3":
                    print("ok tu vas combattre avec \(squad[2].characterName) le \(squad[2].characterType)")
                default: print("Merci de choisir un personnage de ton équipe en tapant le numéro correspondant à ton choix !")
                pickFighter()
                }
            }
    }
    
}


// return playershp += damage
