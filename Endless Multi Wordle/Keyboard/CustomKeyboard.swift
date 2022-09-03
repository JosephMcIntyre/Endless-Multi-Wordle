//
//  CustomKeyboard.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct CustomKeyboard: View {
    @ObservedObject var gameManager: GameManager
    @Binding var guess: Guess
    @Binding var accentColor: Color
    
    var body: some View {
        GeometryReader { geo in
        VStack {
            HStack {
                ForEach(0..<10) { index in
                    KeyboardLetter(letter: $gameManager.rounds[gameManager.currRound].kbLetters[index], guess: $guess)
                }
            }.frame(width: geo.size.width, height: geo.size.width * 0.13)
            HStack {
                ForEach(10..<19) { index in
                    KeyboardLetter(letter: $gameManager.rounds[gameManager.currRound].kbLetters[index], guess: $guess)
                }
            }.frame(width: geo.size.width * 0.9, height: geo.size.width * 0.13)
            HStack {
                KeyboardEnter(gameManager: gameManager, round: $gameManager.rounds[gameManager.currRound], guess: $guess, solution: $gameManager.rounds[gameManager.currRound].solution, accentColor: $accentColor, geo: geo)
                ForEach(19..<26) { index in
                    KeyboardLetter(letter: $gameManager.rounds[gameManager.currRound].kbLetters[index], guess: $guess)
                }
                KeyboardDelete(guess: $guess, geo: geo)
            }.frame(width: geo.size.width, height: geo.size.width * 0.13)
        }
        }
    }
}

