//
//  GameTimerCreateUseCase.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 11/11/24.
//

import Foundation

public struct GameTimerCreateRequest {
    public final class PauseController {
        var isPaused = false
    }
    let initialTimeCount: Double
    let updateInterval: TimeInterval
    let pauseController: PauseController
}

public struct TimerStartedResponse {
    let startWhistleSound: SoundType
}

public struct TimerUpdatedResponse {
    let timeCount: Double
}

public struct TimerEndedResponse {
    let endWhistleSound: SoundType
    let rankingAppearSound: SoundType
}

public protocol GameTimerCreateUseCaseInterface {
    func execute(
        request: GameTimerCreateRequest,
        onTimerStarted: @escaping ((TimerStartedResponse) -> Void),
        onTimerUpdated: @escaping ((TimerUpdatedResponse) -> Void),
        onTimerEnded: @escaping ((TimerEndedResponse) -> Void)
    )
}

public final class GameTimerCreateUseCase: GameTimerCreateUseCaseInterface {
    public init() {}

    public func execute(
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
            
            if !request.pauseController.isPaused {
                timeCount -= request.updateInterval
                onTimerUpdated(TimerUpdatedResponse(timeCount: timeCount))
            }
        }
    }
}
