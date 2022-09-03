//
//  PuzzleRow.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//
import SwiftUI

struct PuzzleRow: View {
    @Binding var guess: Guess
    var body: some View {
        HStack {
            ForEach(0..<guess.letters.count, id: \.self) { index in
                PuzzleLetter(letter: $guess.letters[index], guess: $guess)
            }
        }
    }
}
