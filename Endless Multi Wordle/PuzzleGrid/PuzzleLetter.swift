//
//  PuzzleLetter.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct PuzzleLetter: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var letter: Letter
    @Binding var guess: Guess
    var body: some View {
        ZStack {
            if letter.char != " " {
                Image(systemName: "\(letter.char).square.fill")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .scaledToFit()
                    .bold()
                    .foregroundStyle(colorScheme == .light && letter.state == LetterState.Unused ? .black : .white, letter.state == LetterState.Correct ? .green : letter.state == LetterState.Somewhere ? .yellow : letter.state == LetterState.Incorrect ? Color(.darkGray) : .clear)
                    .fontWeight(.thin)
                }
            if letter.state == LetterState.Unused {
                Image(systemName: "square")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(letter.char == " " ? .secondary : !guess.isRealWord ? .red : .primary)
                    .fontWeight(.thin)
            }
        }
    }
}

