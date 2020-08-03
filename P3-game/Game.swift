//
//  Game.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Game {
    let players: [Player]
    // Initialisation de la variable joueurs et de la variable endOfRound
    init(players: [Player]) {
        self.players = players
    }
   
    // ANCIEN EMPLACEMENT DE LAUNCHGAME(), REMETTRE ICI SI BUG
    
    
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
}

