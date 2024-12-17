//
//  PresentationFactory.swift
//
//
//  Created by ウルトラ深瀬 on 22/11/24.
//

import SwiftUI
import ARShootingApp

final class PresentationFactory {
    static func createGameView(frame: CGRect) -> GameView {
        let arShootingController = ARShootingController(frame: frame)
        let deviceMotionController = DeviceMotionController()
        let viewModel = GameViewModel(
            weaponResourceGetUseCase: UseCaseFactory.create(),
            weaponActionExecuteUseCase: UseCaseFactory.create()
        )
        return GameView(
            arShootingController: arShootingController,
            deviceMotionController: deviceMotionController,
            viewModel: viewModel
        )
    }
}
