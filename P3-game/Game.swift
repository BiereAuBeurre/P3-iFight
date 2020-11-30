//
//  Game.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.

import Foundation

class Game {
    // MARK: - Internal properties
    static var round = 0
    
    // MARK: - Private properties
    private var players: [Player] = []
    private let maxNumberOfPlayers = 2
    
    // MARK: - Internal methods
    func startGame() {
        print("Bienvenue dans le jeu joueur \(players.count+1) !\n")
        for _ in 1...maxNumberOfPlayers {
            /// Creation of the team by choosing a name.
            makePlayer()
            /// Creation of the squad of 3 characters.
            makeTeams()
        }
        startFight()
        endOfGame()
    }
    // MARK: - Private methods
    func createOnePlayer(playerName: String) {
        let player = Player(name: playerName)
        players.append(player)
        print("\nTrès bien équipe \(player.name), forme ton équipe de 3 personnages :\n")
    }
    
    private func makePlayer() {
        print("Joueur \(players.count+1) à toi de choisir un nom d'équipe :\n")
        guard let playerName = readLine()?.trimmingCharacters(in: .whitespaces), !playerName.isEmpty else {
            /// If the playerName written by the user doesn't respect the readLine() conditions.
            print("⛔️ Merci de renseigner un nom d'équipe pour continuer ⛔️\n")
            makePlayer()
            return
        }
        /// If there's more than one player, check if the name is similar than the previous player's one. If it is, ask to type a new one.
        if players.count > 0 {
            if players[0].isEqualTo(name: playerName) {
                print("⛔️ Trop tard ! Ce nom d'équipe est déjà pris, merci d'en choisir un différent ⛔️")
                return makePlayer()
            } else {
                createOnePlayer(playerName: playerName)
            }
        } else {
            createOnePlayer(playerName: playerName)
        }
    }

    private func makeTeams() {
        /// Creation of a squad for each player.
        for player in players {
            player.makeMySquad()
        }
    }
    
    private func endOfGame() {
        /// Printing the game's statistics for both players[0] and players[1] when the while condition (one squad isn't alive anymore) in startFight() {} isn't respected anymore.
        print ("\n                    🕹🎮 GAME OVER 🎮🕹\n"
                + "\nAprès \(Game.round) rounds la partie est terminée, merci d'avoir joué ! 😊\n\n"
                + "\n                   ⚔️ \(players[0].name) 🆚 \(players[1].name) ⚔️\n\n")
        players[0].showStatistic(opponent: players[1])
        sleep(UInt32(1.0))
        players[1].showStatistic(opponent: players[0])
    }
    
    private func startFight() {
        while players[0].isAllSquadAlive() && players[1].isAllSquadAlive() {
            for player in players {
                /// If the fighting player is equal to players[0] (by having the same name thanks to the Player's extension Equatable), he'll attack players[1], else {} will make attack the other squad.   ⬇️
                if players[0] == player {
                    player.pickFighterAndAction(squadToAttack: players[1].squad)
                } else {
                    player.pickFighterAndAction(squadToAttack: players[0].squad)
                }
                Game.round += 1
            }
        }
    }
}
