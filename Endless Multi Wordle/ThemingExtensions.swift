//
//  ThemingExtensions.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

extension Image {
    func rowSymbolModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 22, height: 22)
            .padding(.trailing, 5)
    }
}

extension Image {
    func rowSymbolModifier2() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 22, height: 22)
            .padding(.trailing, 5)
            .foregroundColor(.white)
    }
}
