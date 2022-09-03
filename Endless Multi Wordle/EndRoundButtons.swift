//
//  EndRoundButtons.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct RoundEndButtons: View {
    @ObservedObject var gameManager: GameManager
    @ObservedObject var round: Round
    @Binding var accentColor: Color
    
    var body: some View {
        VStack {
            HStack {
                ShareButton(round: round, accentColor: $accentColor)
                NextGameButton(gameManager: gameManager, accentColor: $accentColor)
            }.padding(.top)
        }
    }
}

struct ShareButton: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var round: Round
    @Binding var accentColor: Color
    @State private var shareText = ""
    
    var body: some View {
        ShareLink(item: "\(shareText) https://github.com/JosephMcIntyre/Unlimited-Word-Guesser-Wordle-") {
            HStack {
                Spacer()
                Image(systemName: "square.and.arrow.up").rowSymbolModifier2()
                Text("Share")
                Spacer()
            }.foregroundColor(.white)
            .bold()
            .padding()
            .background(Capsule().foregroundColor(accentColor))
        }
        .onAppear {
            shareText = "\(round.solution.count)-Letter Word: \(round.state == RoundState.Won ? round.currGuess+1 : 0)/\(round.solution.count+1)"
            for index in round.results.indices {
                shareText.append("\n\(round.results[index])")
            }
            
        }
    }
}

struct NextGameButton: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var gameManager: GameManager
    @Binding var accentColor: Color
    var body: some View {
        Button {
            dismiss()
            gameManager.StartNewGame()
        } label: {
            HStack {
                Spacer()
                Image(systemName: "arrow.forward").rowSymbolModifier2()
                Text("New Game")
                Spacer()
            }.foregroundColor(.white)
            .bold()
            .padding()
            .background(Capsule().foregroundColor(accentColor))
        }
    }
}
