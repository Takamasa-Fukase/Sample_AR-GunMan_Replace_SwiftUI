//
//  PresentationFactory.swift
//
//
//  Created by ウルトラ深瀬 on 22/11/24.
//

import SwiftUI
import ARShootingApp
import WeaponControlMotion

final class PresentationFactory {
    static func createGameView(frame: CGRect) -> GameView {
        let arShootingController = ARShootingController(frame: frame)
        let motionDetector = WeaponControlMotionDetector()
        let viewModel = GameViewModel(
            weaponResourceGetUseCase: UseCaseFactory.create(),
            weaponActionExecuteUseCase: UseCaseFactory.create()
        )
        return GameView(
            arShootingController: arShootingController,
            motionDetector: motionDetector,
            viewModel: viewModel
        )
    }
}
