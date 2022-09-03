//
//  KeyboardEnter.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct KeyboardEnter: View {
    @ObservedObject var gameManager: GameManager
    @Binding var round: Round
    @Binding var guess: Guess
    @Binding var solution: [String]
    @Binding var accentColor: Color
    @State var geo: GeometryProxy
    
    var body: some View {
        Button {
            var letters: [String] = []
                for index in guess.letters.indices {
                    letters.append(guess.letters[index].char)
                }
            CheckSpelling(letters: letters)
            if guess.isRealWord {
                CheckWord(letters: letters)
            }
        } label: {
            Image(systemName: "checkmark.rectangle.fill")
                .symbolRenderingMode(.palette)
                .resizable()
                .frame(width: geo.size.width * 0.13)
                .foregroundStyle(.white, accentColor)
                .opacity(guess.letters.contains(where: {$0.char == " "}) ? 0.5 : 1.0)
        }.disabled(guess.letters.contains(where: {$0.char == " "}))
    }
    
    
    
    func CheckSpelling(letters: [String] ) {
        var word = ""
        for i in letters.indices {
            word.append(letters[i])
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if misspelledRange.location == NSNotFound {
             guess.isRealWord = true
        }
        else {
             guess.isRealWord = false
        }
    }
    
    func CheckWord(letters: [String]) {
        // check guess for exact match to solution
        if letters == solution {
            round.state = RoundState.Won
            for i in guess.letters.indices {
                guess.letters[i].state = LetterState.Correct
                if let index = round.kbLetters.firstIndex(where: { $0.char == guess.letters[i].char } ) {
                    round.kbLetters[index].state = LetterState.Correct
                }
            }
            var solutionWord = ""
            for i in solution.indices {
                solutionWord.append(solution[i])
            }
            gameManager.solvedWords.append(solutionWord)
            if let index = gameManager.wordBank.firstIndex(of: solutionWord) {
                gameManager.wordBank.remove(at: index)
            }
            gameManager.statistics.currStreak += 1
            gameManager.statistics.wordsSolved += 1
            round.getResultsGrid()
        } else {
            // checks guess for correct letters
            for i in letters.indices {
                if let index = round.kbLetters.firstIndex(where: { $0.char == guess.letters[i].char } ) {
                    if letters[i] == solution[i] {
                        guess.letters[i].state = LetterState.Correct
                        round.kbLetters[index].state = LetterState.Correct
                    }
                }
            }
            // checks for incorrect letters
            for i in letters.indices {
                if let index = round.kbLetters.firstIndex(where: { $0.char == guess.letters[i].char } ) {
                    if !solution.contains(letters[i]) {
                        guess.letters[i].state = LetterState.Incorrect
                        round.kbLetters[index].state = LetterState.Incorrect
                    }
                }
            }
            // checks solutions if it contains guess letters somewhere
            for i in letters.indices {
                if let index = round.kbLetters.firstIndex(where: { $0.char == guess.letters[i].char } ) {
                    if solution.contains(letters[i]) && letters[i] != solution[i] {
                        let guessIndex = letters.allIndices(of: guess.letters[i].char)
                        let solutionIndex = solution.allIndices(of: guess.letters[i].char)
                        var statusCorrCount = 0
                        var statusSomeCount = 0
                        for k in guessIndex.indices {
                            if guess.letters[guessIndex[k]].state == LetterState.Correct {
                                statusCorrCount += 1
                            }
                            if guess.letters[guessIndex[k]].state == LetterState.Somewhere {
                                statusSomeCount += 1
                            }
                        }
                        if statusCorrCount == 0 && statusSomeCount == 0 {
                            guess.letters[i].state = LetterState.Somewhere
                        }
                        else if statusCorrCount+statusSomeCount < solutionIndex.count {
                            guess.letters[i].state = LetterState.Somewhere
                        }
                        else {
                            guess.letters[i].state = LetterState.Incorrect
                        }
                        if round.kbLetters[index].state != LetterState.Correct {
                            round.kbLetters[index].state = LetterState.Somewhere
                        }
                    }
                }
            }
            if round.currGuess != gameManager.mode.length {
                round.currGuess += 1
            } else if round.currGuess == gameManager.mode.length {
                round.state = RoundState.Lost
                gameManager.statistics.currStreak = 0
                round.getResultsGrid()
            }
        }
    }
    
}

extension Collection where Element : Equatable {
    func allIndices(of target:Element) -> [Int] {
        let indices = self.enumerated().reduce(into: [Int]()) {
            if $1.1 == target {$0.append($1.0)}
        }
        return indices
    }
}

