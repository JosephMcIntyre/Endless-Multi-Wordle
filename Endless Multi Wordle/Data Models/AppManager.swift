//
//  AppManager.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import Foundation
import SwiftUI

class AppManager: ObservableObject {
    @Published var userName = ""
    @Published var gameModes: [GameManager] = [
        GameManager(mode: GameMode.Five),
        GameManager(mode: GameMode.Six),
        GameManager(mode: GameMode.Seven),
        GameManager(mode: GameMode.Eight)
    ]
    @Published var currMode: Int = 0
    @Published var newMode: Int = 0
    @Published var overallStats = Statistics()
    @Published var statsToShow = 4
    @Published var onboardingDone = false
    
    @Published var accentColor: Color = .blue
    
    func DeleteAccount() {
        self.userName = ""
        self.gameModes = [
            GameManager(mode: GameMode.Five),
            GameManager(mode: GameMode.Six),
            GameManager(mode: GameMode.Seven),
            GameManager(mode: GameMode.Eight)
        ]
        self.currMode = 0
        self.overallStats = Statistics()
        self.statsToShow = 4
        self.accentColor = .blue
    }
    
    func ResetAccount() {
        self.gameModes = [
            GameManager(mode: GameMode.Five),
            GameManager(mode: GameMode.Six),
            GameManager(mode: GameMode.Seven),
            GameManager(mode: GameMode.Eight)
        ]
        self.currMode = 0
        self.overallStats = Statistics()
        self.statsToShow = 4
        self.accentColor = .blue
    }
    
    func getOverallStates() {
        for index in gameModes.indices {
            overallStats.wordsSolved += gameModes[index].statistics.wordsSolved
            overallStats.roundsPlayed += gameModes[index].statistics.roundsPlayed
            overallStats.roundsRestarted += gameModes[index].statistics.roundsRestarted
            if gameModes[index].statistics.currStreak > overallStats.currStreak {
                overallStats.currStreak = gameModes[index].statistics.currStreak
            }
            if gameModes[index].statistics.bestStreak > overallStats.bestStreak {
                overallStats.bestStreak = gameModes[index].statistics.bestStreak
            }
            overallStats.totalWords += gameModes[index].statistics.totalWords
        }
    }
}

enum GameMode: CustomStringConvertible {
    
    case GettingStarted
    case Five
    case Six
    case Seven
    case Eight
    
    var description: String {
        switch self {
            case .GettingStarted: return "Let's Go!"
            case .Five: return "5-Letter"
            case .Six: return "6-Letter"
            case .Seven: return "7-Letter"
            case .Eight: return "8-Letter"
        }
    }
    
    var length: Int {
        switch self {
            case .GettingStarted: return 0
            case .Five: return 5
            case .Six: return 6
            case .Seven: return 7
            case .Eight: return 8
        }
    }
    
    var wordBank: [String] {
        switch self {
            case .GettingStarted: return []
            case .Five: return fiveLetWords
            case .Six: return sixLetWords
            case .Seven: return sevenLetWords
            case .Eight: return eightLetWords
        }
    }
}

struct Statistics {
    var wordsSolved: Int = 0
    var roundsPlayed: Int = 0
    var roundsRestarted: Int = 0
    var currStreak: Int = 0
    var bestStreak: Int = 0
    var winRatio: Int = 0
    var totalWords: Int = 0
    
}
