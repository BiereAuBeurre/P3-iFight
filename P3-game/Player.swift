//  Player.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Player {
    var team: [String] = []
    func createMySquad() {
        
        while team.count < 3 {
            print("Choisi le  personnage numero \(team.count+1)"
                + "\n1. Magicien"
                + "\n2. Chevalier"
                + "\n3. Dragon"
                + "\n4. Druide"
                + "\n5. Sorcière")
            if let choice = readLine() {
                switch choice {
                case "1" :
                    chooseNameOfCharacter(typeOfCharacter: "Magicien")
                case "2" :
                    chooseNameOfCharacter(typeOfCharacter: "Chevalier")
                case "3" :
                    chooseNameOfCharacter(typeOfCharacter: "Dragon")
                case "4" :
                    chooseNameOfCharacter(typeOfCharacter: "Druide")
                case "5" :
                    chooseNameOfCharacter(typeOfCharacter: "Sorcière")
                default: print("Merci de taper un chiffre entre 1 et 5 pour chosir le personnage correspondant")
                }
            }
        }
    }
    
    func chooseNameOfCharacter(typeOfCharacter: String) {
            print("Tu as choisi le \(typeOfCharacter), comment veux tu l'appeler ?")
            if team.isEmpty {
                team["\(typeOfCharacter)"] = readLine()
                print("le nom de ton héros est bien enregistré")
            } else {
                for name in team {
                    if readLine() != name {
                        team["\(typeOfCharacter)"] = readLine()
                        print("le nom de ton héros est bien enregistré")
                    } else {
                        print("Ce nom est déjà pris.")
                        chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
                    }
                }
            }
    }
    
    // comment afficher dans fight les persos sélectionnés dans createMySquad ?!
    
    func fight() {
        //choix du character par le player parmi le squad
        //print("Sélectionne le personnage que tu souhaites faire combattre"
        // + "\n1. Magicien
        //+ "\n2. Chevalier
        //+ \n3. Dragon
        
        // puis éxécuter
        // return playershp += damage
        
        
        //if let choice = readline() {
        // switch choice {
        //case "1" : Character.magicien(p: 100, weapon: "Baguette magique")
        //case "2" : Character.chevalier() //même chose sur les lignes d'en dessous
        //case "3" : Character.dragon()
        //case "4" : Character.druide()
        //case "5" : Character.sorcière()
        // }
        //}
        
        
    }
}
