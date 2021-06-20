//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        for hand in self.hand! {
            if hand.value.rawValue == card.value.rawValue {
                return true
            }
        }
        return false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        for (cardOne, cardTwo) in table {
            if (checkIfCanTossWhenAttacking(card: cardOne) || checkIfCanTossWhenAttacking(card: cardTwo)) {
                return true
            }
        }
        return false
    }
}
