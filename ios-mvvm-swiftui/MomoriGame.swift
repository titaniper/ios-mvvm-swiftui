//
//  MomoriGame.swift
//  ios-mvvm-swiftui
//
//  Created by kang juyoung on 2020/07/21.
//  Copyright © 2020 jooyoung. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    var point = 0;
    
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    point += 2
                } else {
                    point -= 1
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        print("card point: \(point)")
    }
    
    mutating func restart()  {
        // TODO 개선
        self.reset();
        self.suffle()
    }
    
    mutating func reset() {
         // TODO: View model 에서 처음부터 다시 리스트를 받도록 변경
        for index in cards.indices  {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        self.point = 0
    }
    
    func getPoint() -> Int {
        return self.point
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        
        self.reset();
        self.suffle()
    }
    
    mutating func suffle() {
        // TODO: MemoryGame 으로 옮길 것
        self.cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
