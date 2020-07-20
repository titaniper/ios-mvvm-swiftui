//
//  EmojiMemoryGame.swift
//  ios-mvvm-swiftui
//
//  Created by kang juyoung on 2020/07/21.
//  Copyright © 2020 jooyoung. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func chose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}