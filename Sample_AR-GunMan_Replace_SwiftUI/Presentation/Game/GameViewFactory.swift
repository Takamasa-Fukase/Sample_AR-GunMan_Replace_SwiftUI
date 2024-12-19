//
//  GameViewFactory.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 19/12/24.
//

import Foundation
import ARShootingApp
import WeaponControlMotion

final class GameViewFactory {
    static func create(frame: CGRect) -> GameView {
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
