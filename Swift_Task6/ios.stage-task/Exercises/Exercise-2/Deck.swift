import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }

}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        
        var cardDeck: [Card] = []
        for suit in suits {
            for value in values {
                var card = Card.init(suit: suit, value: value)
                cardDeck.append(card)
            }
        }
        return cardDeck
    }

    public mutating func shuffle() {
        var unShuffled = cards
        var shuffled: [Card] = []
        
        for _ in 0..<cards.count {
            let randomIndex = Int.random(in: 0..<unShuffled.count)
            shuffled.append(unShuffled.remove(at: randomIndex))
        }
        cards = shuffled
    }

    public mutating func defineTrump() {
        trump = cards[0].suit
        setTrumpCards(for: trump!)
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        
        for player in players {
            var hand: [Card] = []
            for _ in 0...5 {
                hand.append(cards.first!)
                cards.removeFirst()
            }
            player.hand = hand
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        for (i, _) in cards.enumerated() {
            if cards[i].suit == suit {
                cards[i].isTrump = true
            }
        }
    }
}

