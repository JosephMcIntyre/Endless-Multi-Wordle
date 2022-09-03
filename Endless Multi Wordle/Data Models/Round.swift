//
//  Round.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import Foundation
import SwiftUI

class Round: ObservableObject {
    @Published var solution : [String] = []
    @Published var kbLetters = KBLetters
    @Published var currGuess: Int = 0
    @Published var guesses: [Guess] = []
    
    @Published var state = RoundState.Playing
    @Published var results: [String] = []
    
    func getResultsGrid() {
        var i = 0
        while i <= currGuess {
            var k = 0
            var resultsRow = ""
            while k < solution.count {
                resultsRow.append(guesses[i].letters[k].state.description)
                k += 1
            }
            results.append(resultsRow)
            i += 1
        }
    }
}

enum RoundState {
    case Playing
    case Won
    case Lost
}

struct Guess {
    var id: Int = 0
    var letters: [Letter] = []
    var currInput = 0
    var isRealWord: Bool = true
    
}

struct Letter {
    var id: Int = 0
    var char = " "
    var state = LetterState.Unused
}

enum LetterState: CustomStringConvertible {
    case Unused
    case Somewhere
    case Correct
    case Incorrect
    
    var description: String {
        switch self {
            case .Unused: return "⬜️"
            case .Somewhere: return "🟨"
            case .Correct: return "🟩"
            case .Incorrect: return "⬜️"
        }
    }
    
    var color: Color {
        switch self {
            case .Unused: return .clear
            case .Somewhere: return .yellow
            case .Correct: return .green
            case .Incorrect: return Color(.darkGray)
        }
    }
}
