//
//  ProfileView.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var manager: AppManager
    
    @State private var showResetAlert = false
    @State private var showDeleteAlert = false
    @FocusState var editingName: Bool
    
    var body: some View {
        VStack {
            GroupBox {
                TextField("\(manager.userName != "" ? manager.userName : "User Name")", text: $manager.userName)
                    .focused($editingName)
            }.padding()
            Spacer()
            HStack {
                Button {
                    showResetAlert.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("Reset Profile").foregroundColor(.white)
                        Spacer()
                    }.padding()
                    .background(Capsule().foregroundColor(.blue))
                }.buttonStyle(.plain)
                Button {
                    showDeleteAlert.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete Account").foregroundColor(.white)
                        Spacer()
                    }.padding()
                    .background(Capsule().foregroundColor(.red))
                }.buttonStyle(.plain)
            }.padding()
            
        }
        .navigationTitle("Profile")
        .confirmationDialog("Reset Profile, Solved Words, and Statistics", isPresented: $showResetAlert, titleVisibility: .visible) {
            Button("Reset Account Data", role: .destructive) {
                manager.ResetAccount()
                dismiss()
            }
        }
        .confirmationDialog("Delete Account and all Data", isPresented: $showDeleteAlert, titleVisibility: .visible) {
            Button("Delete Account", role: .destructive) {
                DeleteAccount()
            }
        }
    
    }
    
    func ResetAccount() {
        
    }
    
    func DeleteAccount() {
        manager.DeleteAccount()
        editingName = true
        
    }
}


