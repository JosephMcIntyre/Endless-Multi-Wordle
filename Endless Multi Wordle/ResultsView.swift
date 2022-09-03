//
//  ResultsView.swift
//  Endless Multi Wordle
//
//  Created by Joseph McIntyre on 9/3/22.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var round: Round

    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                Text("\(round.state == RoundState.Won ? round.currGuess+1 : 0)/\(round.solution.count+1)")
                VStack {
                    ForEach(round.results, id: \.self) { resultRow in
                        HStack {
                            Text(resultRow)
                        }
                    }
                }.padding()
                Text(getSolutionWord())
                    .textCase(.uppercase)
                   
            }
            Spacer()
        }
    }
    
    func getSolutionWord() -> String {
        var word = ""
        for i in round.solution.indices {
            word.append(round.solution[i])
        }
        return word
    }
}

