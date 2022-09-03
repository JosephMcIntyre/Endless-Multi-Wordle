//
//  StatsView.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct StatsView: View {
    @Binding var statistics: Statistics
    @Binding var accentColor: Color
    
    func totalProgress() -> Double {
        var progress = 0.00
        if statistics.totalWords > 0 {
            progress = Double(statistics.wordsSolved / statistics.totalWords)
        }
        return progress
    }
    
    
    var body: some View {
        HStack {
            Image(systemName: "square.filled.and.line.vertical.and.square")
                .rowSymbolModifier()
                .foregroundColor(accentColor)
            Text("Win Ratio:")
            Spacer()
            Text("\(statistics.wordsSolved)/\(statistics.roundsPlayed)")
                .foregroundColor(.secondary)
        }
        HStack {
            Image(systemName: "flag.checkered")
                .rowSymbolModifier()
                .foregroundColor(accentColor)
            Text("Words Solved:")
            Spacer()
            Text("\(statistics.wordsSolved)")
                .foregroundColor(.secondary)
        }
        HStack {
            Image(systemName: "gamecontroller.fill")
                .rowSymbolModifier()
                .foregroundColor(accentColor)
            Text("Rounds Played:")
            Spacer()
            Text("\(statistics.roundsPlayed)")
                .foregroundColor(.secondary)
        }
        HStack {
            Image(systemName: "arrow.counterclockwise")
                .rowSymbolModifier()
                .foregroundColor(accentColor)
            Text("Words Restarted:")
            Spacer()
            Text("\(statistics.roundsRestarted)")
                .foregroundColor(.secondary)
        }
        HStack {
            Image(systemName: "star")
                .rowSymbolModifier()
                .foregroundColor(accentColor)
            Text("Current Win Streak:")
            Spacer()
            Text("\(statistics.currStreak)")
                .foregroundColor(.secondary)
        }
        HStack {
            Image(systemName: "star.fill")
                .rowSymbolModifier()
                .foregroundColor(accentColor)
            Text("Highest Win Streak:")
            Spacer()
            Text("\(statistics.bestStreak)")
                .foregroundColor(.secondary)
        }
        HStack {
            Image(systemName: "chart.pie.fill")
                .rowSymbolModifier()
                .foregroundColor(accentColor)
            Text("Words Left:")
            Spacer()
            Text("\(statistics.totalWords-statistics.wordsSolved)")
                .foregroundColor(.secondary)
        }
        
        .onAppear {
            if statistics.currStreak > statistics.bestStreak {
                statistics.bestStreak = statistics.currStreak
            }
        }
    }
}



