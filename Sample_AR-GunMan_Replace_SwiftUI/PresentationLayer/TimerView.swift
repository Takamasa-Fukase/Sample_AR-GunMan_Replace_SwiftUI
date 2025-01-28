//
//  TimerView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 28/1/25.
//

import SwiftUI

struct TimerView: View {
    let useCase = GameTimerCreateUseCase_MillisecVer()
    @State var isStarted = false
    @State var timeCount: Double = 0.1
    
    var body: some View {
        VStack {
            if isStarted {
                Text(timeCount.timeCountText)
            } else {
                ProgressView()
            }
        }
        .task() {
            do {
                try await Task.sleep(nanoseconds: 1000000000)
                isStarted = true
            } catch {
                
            }
            useCase.execute(
                request: .init(
                    initialTimeCount: timeCount,
                    updateInterval: 0.01,
                    pauseController: .init(isPaused: false)
                )
            ) { _ in } onTimerUpdated: { res in
                
                timeCount = res.timeCount
                
            } onTimerEnded: { res in }
            
        }
    }
}

#Preview {
    TimerView()
}
