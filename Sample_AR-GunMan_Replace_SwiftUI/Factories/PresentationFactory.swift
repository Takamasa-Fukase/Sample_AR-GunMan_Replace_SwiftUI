//
//  PresentationFactory.swift
//
//
//  Created by ウルトラ深瀬 on 22/11/24.
//

import SwiftUI

final class PresentationFactory {
    static func createGameView() -> GameView {
        let viewModel = GameViewModel(
            weaponResourceGetUseCase: UseCaseFactory.create(),
            weaponActionExecuteUseCase: UseCaseFactory.create()
        )
        return GameView(viewModel: viewModel)
    }
    
    // MARK: Private Methods
    
    private static func createSoundPlayer() -> SoundPlayerInterface {
        return SoundPlayer()
    }
}
