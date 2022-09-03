//
//  SettingsSheet.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct SettingsSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var manager: AppManager
    
    @State private var showModeChangeAlert = false
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Image(systemName: "gamecontroller.fill")
                        .rowSymbolModifier()
                        .foregroundColor(manager.accentColor)
                    Text(" Game Mode")
                    Spacer()
                    Picker("", selection: $manager.newMode) {
                        Text("\(manager.gameModes[0].mode.description)").tag(0)
                        Text("\(manager.gameModes[1].mode.description)").tag(1)
                        Text("\(manager.gameModes[2].mode.description)").tag(2)
                        Text("\(manager.gameModes[3].mode.description)").tag(3)
                    }
                }
                .onChange(of: manager.newMode) { mode in
                    showModeChangeAlert.toggle()
                }
                Section(content: {
                    if manager.statsToShow == 4 {
                        StatsView(statistics: $manager.overallStats, accentColor: $manager.accentColor)
                    } else {
                        StatsView(statistics: $manager.gameModes[manager.statsToShow].statistics, accentColor: $manager.accentColor)
                    }
                }, header: {
                    Menu {
                    Picker("", selection: $manager.statsToShow) {
                        Text("Overall").tag(4)
                        Text("\(manager.gameModes[0].mode.description)").tag(0)
                        Text("\(manager.gameModes[1].mode.description)").tag(1)
                        Text("\(manager.gameModes[2].mode.description)").tag(2)
                        Text("\(manager.gameModes[3].mode.description)").tag(3)
                    }
                    } label: {
                        HStack {
                            Text("\(manager.statsToShow == 4 ? "Overall" : manager.gameModes[manager.statsToShow].mode.description) Stats")
                            Image(systemName: "chevron.up.chevron.down")
                        }.foregroundColor(.secondary).font(.footnote)
                    }
                    .onChange(of: manager.statsToShow) { statsToShow in
                        if statsToShow == 4 {
                            manager.getOverallStates()
                        }
                    }
                    
                })
                
                Section(content: {
                    HStack {
                        Image(systemName: "circle.hexagongrid.fill")
                            .rowSymbolModifier()
                            .foregroundColor(manager.accentColor)
                        Text("Accent Color")
                        Spacer()
                        ColorPicker("", selection: $manager.accentColor, supportsOpacity: false)
                    }
                    NavigationLink(destination: {
                        ProfileView(manager: manager)
                    }, label: {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .rowSymbolModifier()
                                .foregroundColor(manager.accentColor)
                            Text("Profile")
                        }
                    })
                    NavigationLink(destination: {
                        AboutView()
                    }, label: {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .rowSymbolModifier()
                                .foregroundColor(manager.accentColor)
                            Text("About")
                        }
                    })
                }, header: { Text("General") })
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                        .foregroundColor(manager.accentColor)
                    }
                }
            }
            .confirmationDialog("Confirm Mode change - Progress in Current Round will be lost", isPresented: $showModeChangeAlert, titleVisibility: .visible) {
                Button("Yes") {
                    manager.currMode = manager.newMode
                    manager.gameModes[manager.currMode].StartNewGame()
                    dismiss()
                }
            }
        }
    }
}


