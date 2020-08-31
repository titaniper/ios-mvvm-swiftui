//
//  EmojiMemoryGameView.swift
//  ios-mvvm-swiftui
//
//  Created by kang juyoung on 2020/07/20.
//  Copyright © 2020 jooyoung. All rights reserved.
//

import SwiftUI

import SwiftUI

struct EmojiMemoryGameView: View {
    // 구독 모델에 ObservedObject 어노테이션을 붙여주어야 한다.
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    // You never access this "var body"
    // view body는 private 를 허용하지 않는다.
    var body: some View {
        VStack{
            self.Header()
            self.Body()
        }
    }
    
    private func Header() -> some View {
        HStack {
            Button("New Game") {
                self.viewModel.restart()
            }
            Text("Point \(viewModel.getPoint())")
        }
    }
    
    private func Body() -> some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }.padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
