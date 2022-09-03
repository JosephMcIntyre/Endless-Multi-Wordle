//
//  GameManager.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import Foundation
import SwiftUI

class GameManager: ObservableObject {
    @Published var mode: GameMode
    
    @Published var statistics = Statistics()
    @Published var wordBank: [String]
    @Published var solvedWords: [String] = []
    @Published var unsolvedWords: [String] = []
    
    @Published var currRound: Int = 0
    @Published var rounds: [Round] = []
    @Published var wordBankCount: Int = 0
     
     func totalWordsSolved() -> String {
        let wordsSolved = "\(solvedWords.count / wordBank.count)"
        
        return wordsSolved
     }
     
     func CreateRound() -> Round {
        let round = Round()
        var letter = Letter()
        var guess = Guess()
        
        // initializing amount of letters
        var i = 0
        while i < mode.length {
            letter.id = i
            guess.letters.append(letter)
            i += 1
        }
        // initializing amount of guesses
        var x = 0
        while x < (mode.length + 1) {
            guess.id = x
            round.guesses.append(guess)
            x += 1
        }
        return round
    }
    
     func getNewWord() -> [String] {
        let nextWord = wordBank.randomElement()!
        let newWord = nextWord.map { String($0) }
        return newWord
    }
     
      func StartNewGame() {
        let newRound = CreateRound()
        newRound.solution = getNewWord()
        rounds.append(newRound)
        currRound += 1
        statistics.roundsPlayed += 1
     }

     func RestartCurrGame() {
        let prevRound = self.rounds[rounds.count-1]
        let prevSolution = prevRound.solution
        let newRound = CreateRound()
        newRound.solution = prevSolution
        rounds.append(newRound)
        currRound += 1
        statistics.roundsPlayed += 1
        statistics.roundsRestarted += 1
    }
    
    
    init(mode: GameMode) {
        self.mode = mode
        self.wordBank = mode.wordBank
        let newRound = CreateRound()
        newRound.solution = getNewWord()
        rounds.append(newRound)
        statistics.roundsPlayed = 0
        statistics.totalWords = wordBank.count
        wordBankCount = wordBank.count
    }
        
}
