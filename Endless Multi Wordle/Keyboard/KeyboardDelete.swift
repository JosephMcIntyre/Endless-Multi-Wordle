//
//  KeyboardDelete.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct KeyboardDelete: View {
    @Binding var guess: Guess
    @State var geo: GeometryProxy

    var body: some View {
        Button {
            DeleteLetter()
        } label: {
            Image(systemName: "xmark.rectangle.fill")
                .symbolRenderingMode(.palette)
                .resizable()
                .frame(width: geo.size.width * 0.13)
                .foregroundStyle(.white, .red)
        }
    }
    
    func DeleteLetter() {
        if guess.currInput > 0 {
            guess.currInput -= 1
            guess.isRealWord = true
        }
        guess.letters[guess.currInput].char = " "
    }
    
}
