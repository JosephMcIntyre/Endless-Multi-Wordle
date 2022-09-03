//
//  KeyboardLetter.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct KeyboardLetter: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var letter: Letter
    @Binding var guess: Guess
    
    var body: some View {
        Button {
            AddLetter()
        } label: {
            Image(systemName: "\(letter.char).square.fill")
                .symbolRenderingMode(.palette)
                .resizable()
                .foregroundStyle(colorScheme == .light && letter.state == LetterState.Unused ? .black : .white, letter.state == LetterState.Correct ? .green : letter.state == LetterState.Somewhere ? .yellow : letter.state == LetterState.Incorrect ? Color(.darkGray) : Color(.systemGray6))
        }
    }
    
    func AddLetter() {
        if guess.currInput < guess.letters.count && guess.letters[guess.currInput].char == " " {
            guess.letters[guess.currInput].char = letter.char
            guess.currInput += 1
        }
    }
}

