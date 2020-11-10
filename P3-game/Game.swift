//
//  Game.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Game {
    
    let maxNumberOfPlayers = 2
    var players: [Player] = []
    static var round = 0
    var playerNames = [String]()
    
    private func makePlayer() {
        print("Joueur \(players.count+1) à toi de choisir un nom d'équipe :\n")
        if let playerName = readLine()?.trimmingCharacters(in: .whitespaces), !playerName.isEmpty {
            if playerNames.contains(playerName) {
                print("⛔️ Trop tard ! Ce nom d'équipe est déjà pris, merci d'en choisir un différent ⛔️")
                makePlayer()
            } else {
                let player = Player(name: playerName)
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
    
    private func makeTeams() {
        /* Assigner les équipes */
        for player in players {
            player.makeMySquad()
        }
    }
    
    public func startGame() {
        print("Bienvenue dans le jeu joueur \(players.count+1) !\n")
        for _ in 1...maxNumberOfPlayers {
            // Création de l'équipe par un choix de nom ⬇️
            makePlayer()
            // Création du squad composé de 3 personnages ⬇️
            makeTeams()
        }
        startFight()
    }
    
    private func startFight() {
        while players[0].isAllSquadAlive() && players[1].isAllSquadAlive() {
            for player in players {
                player.pickFighter()
                Game.round += 1
                Player.indexCountHelper += 1
            }
            Player.indexCountHelper = 0
        }
        endOfGame()
    }
    
    private func endOfGame() {
        // Print les stats de fin de partie, pour l'index 0 et 1 correspondant aux 2 players quand la condition while l55 n'est plus respectée ⬇️
        print ("\n                   🕹🎮 GAME OVER 🎮🕹\n"
            + "\nAprès \(Game.round) rounds la partie est terminée, merci d'avoir joué ! 😊\n\n"
            + "\n                   ⚔️ \(game.players[0].name) 🆚 \(game.players[1].name) ⚔️\n\n")
        game.players[0].showStatistic(index: 1)
        sleep(UInt32(1.0))
        game.players[1].showStatistic(index: 0)
    }
}
