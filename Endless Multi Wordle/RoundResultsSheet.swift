//
//  RoundResultsSheet.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct RoundResultsSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var gameManager: GameManager
    @ObservedObject var round: Round
    @Binding var accentColor: Color
    var body: some View {
        NavigationStack {
            VStack {
                GroupBox {
                    StatsView(statistics: $gameManager.statistics, accentColor: $accentColor)
                }.padding()
                GroupBox {
                    ResultsView(round: round)
                }.padding()
                RoundEndButtons(gameManager: gameManager, round: round, accentColor: $accentColor).padding(.horizontal)
                Spacer()
            }
        
            .navigationTitle("Results")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { dismiss() } label: { Text("Done") }
                }
            }
        }
    }
}

