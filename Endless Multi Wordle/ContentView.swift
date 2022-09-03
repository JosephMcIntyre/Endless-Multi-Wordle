//
//  ContentView.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = AppManager()
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    if manager.onboardingDone == false {
                        OnboardingView(manager: manager)
                    } else {
                        PuzzleGrid(gameManager: manager.gameModes[manager.currMode], accentColor: $manager.accentColor).padding()
                    }
                }
            }
            .navigationTitle("\(manager.gameModes[manager.currMode].mode.description)")
            .sheet(isPresented: $showSettingsSheet) { SettingsSheet(manager: manager) }
            .toolbar {
                ToolbarItemGroup {
                    Menu {
                        Button(action: { showSettingsSheet.toggle() }) {  Label("Settings", systemImage: "gear") }
                        Button(action: {
                            manager.gameModes[manager.currMode].RestartCurrGame()
                        }) {  Label("Restart Round", systemImage: "arrow.counterclockwise") }
                        Button(action: {
                            manager.gameModes[manager.currMode].StartNewGame()
                        }) {  Label("New Round", systemImage: "plus") }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(manager.accentColor)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
