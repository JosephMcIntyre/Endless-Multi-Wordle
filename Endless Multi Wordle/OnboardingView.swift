//
//  OnboardingView.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var manager: AppManager
    @FocusState var editingName: Bool
    var body: some View {
        List {
            TextField("What's your Name?", text: $manager.userName)
                .focused($editingName)
            Section {
                HStack {
                    Image(systemName: "gamecontroller.fill").rowSymbolModifier()
                    Text("Game Mode")
                    Spacer()
                    Picker("", selection: $manager.currMode) {
                        Text("5-Letters").tag(0)
                        Text("6-Letters").tag(1)
                        Text("7-Letters").tag(2)
                        Text("8-Letters").tag(3)
                    }
                }
            }
            Section {
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                manager.onboardingDone = true
                                manager.gameModes[manager.currMode].StartNewGame()
                            }
                        }
                    } label: {
                        Text("Let's Go!")
                            .foregroundColor(.white)
                            .padding()
                            .background(Capsule()
                                .foregroundColor(.blue))
                                .opacity(manager.userName.isEmpty ? 0.5 : 1.0)
                    }.disabled(manager.userName.isEmpty)
                    Spacer()
                }
            }.listRowBackground(Color(.clear))
        }
    }
}

