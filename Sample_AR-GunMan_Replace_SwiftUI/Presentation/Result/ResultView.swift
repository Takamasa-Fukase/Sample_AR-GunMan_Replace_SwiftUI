//
//  ResultView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct ResultView: View {
    let score: Double
    @Environment(GameViewPresentationState.self) var gameViewPresentationState
    
    var body: some View {
        VStack {
            Text("SCORE: \(score.scoreText)")
            
            Spacer()
                .frame(height: 60)
            
            Button {
                gameViewPresentationState.isPresented = false
            } label: {
                Text("HOME")
            }
            
            Spacer()
                .frame(height: 40)
            
            Button {
                gameViewPresentationState.isPresented = false
            } label: {
                Text("REPLAY")
            }
        }
    }
}

#Preview {
    ResultView(score: 0.0)
}
