//
//  GameTimerCreateUseCase.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 11/11/24.
//

import Foundation

struct GameTimerCreateRequest {
    let initialTimeCount: Double
    let updateInterval: TimeInterval
}

struct TimerStartedResponse {
    let startWhistleSound: SoundType
}

struct TimerUpdatedResponse {
    let timeCount: Double
}

struct TimerEndedResponse {
    let endWhistleSound: SoundType
    let rankingAppearSound: SoundType
}

protocol GameTimerCreateUseCaseInterface {
    func execute(
        request: GameTimerCreateRequest,
        onTimerStarted: @escaping ((TimerStartedResponse) -> Void),
        onTimerUpdated: @escaping ((TimerUpdatedResponse) -> Void),
        onTimerEnded: @escaping ((TimerEndedResponse) -> Void)
    )
}

final class GameTimerCreateUseCase: GameTimerCreateUseCaseInterface {
    func execute(
        request: GameTimerCreateRequest,
        onTimerStarted: @escaping ((TimerStartedResponse) -> Void),
        onTimerUpdated: @escaping ((TimerUpdatedResponse) -> Void),
        onTimerEnded: @escaping ((TimerEndedResponse) -> Void)
    ) {
        var timeCount: Double = request.initialTimeCount
        
        _ = Timer.scheduledTimer(withTimeInterval: request.updateInterval,
                                 repeats: true) { timer in
            if (timeCount == request.initialTimeCount) {
                onTimerStarted(TimerStartedResponse(startWhistleSound: .startWhistle))
            }
            if (timeCount - request.updateInterval) <= 0 {
                onTimerEnded(TimerEndedResponse(
                    endWhistleSound: .endWhistle,
                    rankingAppearSound: .rankingAppear
                ))
                timer.invalidate()
                return
            }
            timeCount -= request.updateInterval
            onTimerUpdated(TimerUpdatedResponse(timeCount: timeCount))
        }
    }
}
