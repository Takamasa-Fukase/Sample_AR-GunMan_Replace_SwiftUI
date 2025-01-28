//
//  TimerUseCase_MillisecVer.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 28/1/25.
//

import Foundation
import DomainLayer

public struct GameTimerCreateRequest_MillisecVer {
    public final class PauseController {
        public var isPaused = false
        
        public init(isPaused: Bool = false) {
            self.isPaused = isPaused
        }
    }
    let initialTimeCount: Double
    let updateInterval: TimeInterval
    let pauseController: PauseController
    
    public init(
        initialTimeCount: Double,
        updateInterval: TimeInterval,
        pauseController: PauseController
    ) {
        self.initialTimeCount = initialTimeCount
        self.updateInterval = updateInterval
        self.pauseController = pauseController
    }
}

public struct TimerStartedResponse {
    public let startWhistleSound: SoundType
}

public struct TimerUpdatedResponse {
    public let timeCount: Double
}

public struct TimerEndedResponse {
    public let endWhistleSound: SoundType
    public let rankingAppearSound: SoundType
}

public protocol GameTimerCreateUseCaseInterface_MillisecVer {
    func execute(
        request: GameTimerCreateRequest_MillisecVer,
        onTimerStarted: @escaping ((TimerStartedResponse) -> Void),
        onTimerUpdated: @escaping ((TimerUpdatedResponse) -> Void),
        onTimerEnded: @escaping ((TimerEndedResponse) -> Void)
    )
}

public final class GameTimerCreateUseCase_MillisecVer: GameTimerCreateUseCaseInterface_MillisecVer {
    public init() {}

    public func execute(
        request: GameTimerCreateRequest_MillisecVer,
        onTimerStarted: @escaping ((TimerStartedResponse) -> Void),
        onTimerUpdated: @escaping ((TimerUpdatedResponse) -> Void),
        onTimerEnded: @escaping ((TimerEndedResponse) -> Void)
    ) {
        var timeCount: Double = request.initialTimeCount
        
        _ = Timer.scheduledTimer(withTimeInterval: request.updateInterval,
                                 repeats: true) { timer in
            print("timerのクロージャー最初 この時点のcount: \(timeCount), updateInterval: \(request.updateInterval), updateIntervalを引いたら0と同じかそれより小さい : \(timeCount - request.updateInterval <= 0)")
            
            if (timeCount == request.initialTimeCount) {
                onTimerStarted(TimerStartedResponse(startWhistleSound: .startWhistle))
            }
            
            if !request.pauseController.isPaused {
                print("🟦pauseじゃないif文に入った")
                timeCount -= request.updateInterval
                print("🟦timeCountに代入した: \(timeCount)")
                onTimerUpdated(TimerUpdatedResponse(timeCount: timeCount))
                print("🟦onTimerUpdatedを呼んだ")
            }
            
            if timeCount <= 0 {
                print("🟥endのif文に入った")
                onTimerEnded(TimerEndedResponse(
                    endWhistleSound: .endWhistle,
                    rankingAppearSound: .rankingAppear
                ))
                print("🟥onTimerEndedを呼んだ")
                timer.invalidate()
                print("🟥timer.invalidateをした")
            }
        }
    }
}
