//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        
        var card: Card?
        var attackingPlayer: Player?
        
        for player in players {
            
            let hand = player.hand

            for i in 0..<hand!.count {
      
                if hand![i].isTrump && card == nil {
                    card = hand![i]
                    attackingPlayer = player
                }
                else if hand![i].isTrump && card != nil {
                    if hand![i].value.rawValue < card!.value.rawValue {
                        card = hand![i]
                        attackingPlayer = player
                    }
                }
            }
        }
        
        return attackingPlayer
    }
}
