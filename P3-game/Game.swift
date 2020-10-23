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
//    var indexCountHelper = 0
    var players: [Player] = []
    static var round = 0
    var playerNames = [String]()
    var attackedCharacter: Character?
    
    func makePlayer() {
        
        print("Joueur \(players.count+1) à toi de choisir un nom d'équipe :\n")
        // "!" en début de nom de proriété reviens à dire playerName.isEmpty == false
        if let playerName = readLine()?.trimmingCharacters(in: .whitespaces), !playerName.isEmpty {
            if playerNames.contains(playerName) {
                print("⛔️ Trop tard ! Ce nom d'équipe est déjà pris, merci d'en choisir un différent ⛔️")
                makePlayer()
            } else {
                let player = Player()
                player.name = playerName
                players.append(player)
                playerNames.append(playerName)
                print("\nTrès bien équipe \(player.name), forme ton équipe de 3 personnages :\n")
            }
        } else {
            print("⛔️ Merci de renseigner un nom d'équipe pour continuer ⛔️\n")
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
            // Création de l'équipe par un choix de nom ⬇️
            makePlayer()
            // Création du squad composé de 3 personnages ⬇️
            makeTeams()
            // Lancement du combat pour le player à l'index 0 puis à lindex 1, revoir l'écriture du lancement de la fonction car ne peut pas être intégré dans la boucle ou ça fera startfight dans un mauvais ordre
        }
        startFight()
    }
    
    
    func startFight() {
        //        var indexCountHelper = 0
        let player = Player()
        while players[0].areAllMembersSquadDead() && players[1].areAllMembersSquadDead() {
            for player in players {
                print("je passe dans la boucle for")
                player.pickFighter()
                Game.round += 1
//                player.indexCountHelper += 1
//                print("+1 pour indexCountHelper")
            }
            print("fin du tour, les 2 équipes sont passés, je remet indexCountHelper à zéro")
            player.indexCountHelper = 0
        }
    }
    
}


