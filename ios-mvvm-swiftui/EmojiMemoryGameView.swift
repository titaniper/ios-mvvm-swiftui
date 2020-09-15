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
            Button(action: {
                withAnimation(.linear) {
                        self.viewModel.restart()
                }
            }, label: { Text("New Game")})
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
                withAnimation(.linear(duration: 0.75), {
                    self.viewModel.choose(card: card)
                })
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
    
    @State private var animatedBuonusRemining: Double = 0
    
    private func startBonustimeAnimation() {
//        animatedBuonusRemining = card.bonusRemaining
//        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
//            animatedBuonusRemining = 0
//        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
//                Group {
//                    if card.isConsumingBonusTime {
//                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBuonusRemining*360-90), clockwise: true).padding(5).opacity(0.4)
//                            .onAppear {
//                            startBonustimeAnimation()
//                        }
//                    } else {
//                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBuonusRemining*360-90), clockwise: true).padding(5).opacity(0.4)
//                    }
//                }
//                .padding(5).opacity(0.4)
//                .transition(.identity)
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBuonusRemining*360-90), clockwise: true).padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 180 : 0))
                    .animation(Animation.easeInOut(duration: 1))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180), axis: (0, 1, 0))
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
