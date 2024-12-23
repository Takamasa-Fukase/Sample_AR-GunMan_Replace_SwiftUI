//
//  ResultView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct ResultView: View {
    let score: Double
    let toHomeButtonTapped: (() -> Void)
    let replayButtonTapped: (() -> Void)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("SCORE: \(score.scoreText)")
            
            Spacer()
                .frame(height: 60)
            
            Button {
                toHomeButtonTapped()
            } label: {
                Text("HOME")
            }
            
            Spacer()
                .frame(height: 40)
            
            Button {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    dismiss()
                }
                replayButtonTapped()
            } label: {
                Text("REPLAY")
            }
        }
    }
}

#Preview {
    ResultView(
        score: 0.0,
        toHomeButtonTapped: {},
        replayButtonTapped: {}
    )
}
