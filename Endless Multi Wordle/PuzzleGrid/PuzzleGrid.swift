//
//  PuzzleGrid.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct PuzzleGrid: View {
    @ObservedObject var gameManager: GameManager
    @Binding var accentColor: Color
    @State private var showResults = false

    var body: some View {
        VStack {
//        disabled code that reveals current word soltuion
//            HStack {
//                ForEach(0..<gameManager.mode.length, id: \.self) { index in
//                    Text(gameManager.rounds[gameManager.currRound].solution[index])
//                }
//            }
            ForEach(0..<gameManager.mode.length+1, id: \.self) { index in
                PuzzleRow(guess: $gameManager.rounds[gameManager.currRound].guesses[index])
            }
            
            
            ZStack {
                CustomKeyboard(gameManager: gameManager, guess: $gameManager.rounds[gameManager.currRound].guesses[gameManager.rounds[gameManager.currRound].currGuess], accentColor: $accentColor)
                    .padding(.top)
                    .opacity(gameManager.rounds[gameManager.currRound].state == RoundState.Playing ? 1.0 : 0.0)
                    .disabled(gameManager.rounds[gameManager.currRound].state != RoundState.Playing)
                RoundEndButtons(gameManager: gameManager, round: gameManager.rounds[gameManager.currRound], accentColor: $accentColor)
                    .opacity(gameManager.rounds[gameManager.currRound].state != RoundState.Playing ? 1.0 : 0.0)
                    .disabled(gameManager.rounds[gameManager.currRound].state == RoundState.Playing)
            }
        }
        .onChange(of: gameManager.rounds[gameManager.currRound].state) { state in
            if state == RoundState.Won || state == RoundState.Lost {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    showResults.toggle()
                }
            }
        }
        .sheet(isPresented: $showResults) {
            RoundResultsSheet(gameManager: gameManager, round: gameManager.rounds[gameManager.currRound], accentColor: $accentColor)
        }
    }
}





