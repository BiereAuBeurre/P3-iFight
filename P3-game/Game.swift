//
//  Game.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation


class Game {
    
    let maxNumberOfPlayers = 2
    var indexCountHelper = 0
    var players: [Player] = []
    
    func makePlayer() {
        
        print("Joueur \(players.count+1) à toi de choisir un nom d'équipe :")
        if let playerName = readLine()?.trimmingCharacters(in: .whitespaces), !playerName.isEmpty { // reviens à dire playerName.isEmpty == false
            let player = Player()
            player.name = playerName
            players.append(player)
            print("\nTrès bien équipe \(player.name), forme ton équipe de 3 personnages :")
        } else {
            print("merci de renseigner un nom d'équipe")
            makePlayer()
        }
    }
    
    func makeTeams() {
        /* Assigner les équipes */
        for player in players {
            player.makeMySquad()
        }
    }
    
    func startGame() {
        print("Bienvenue dans le jeu joueur \(players.count+1) !\n")
        for _ in 1...maxNumberOfPlayers {
            //          Choix du nom de l'équipe
            makePlayer()
            //        Création de l'équipe composée de 3 personnages
            makeTeams()
        }
    }
    
    func startFight() {
        for _ in 1...maxNumberOfPlayers {
            //          Choix du personnages qui va combattre, pour le perso 1 puis 2
            players[indexCountHelper].pickFighter()
            indexCountHelper += 1
        }
    }
}


// TODO: Initialisation de la variable endOfRound

// Peut-être que pour endOfGame oon fait plutôt une fonction qui affiche les stats de la partie +gagnants et non une variable ?
//func endOfGame() {
//print("this winner's round is \(winner) !")
//init(winner: String) {
//self.winner = winner
//}

//Fonction pour définir winner :
// func winner() {
// if player1.hp > player2.hp {
//print ("\(players1) won the game")
//}
// else {
// print("\(player2) won the game")
//}


