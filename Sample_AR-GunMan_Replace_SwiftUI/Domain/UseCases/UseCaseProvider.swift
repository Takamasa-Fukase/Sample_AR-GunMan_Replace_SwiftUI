//
//  UseCaseProvider.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 19/11/24.
//

import Foundation

final class UseCaseProvider {
    static func makeTutorialUseCase() -> TutorialUseCase {
        return .init(tutorialRepository: RepositoryProvider.makeTutorialRepository())
    }

    static func makeGameTimerCreateUseCase() -> GameTimerCreateUseCase {
        return .init()
    }
    
    static func makeWeaponResourceGetUseCase() -> WeaponResourceGetUseCase {
        return .init(weaponRepository: RepositoryProvider.makeWeaponRepository())
    }
    
    static func makeWeaponStatusCheckUseCase() -> WeaponStatusCheckUseCase {
        return .init()
    }
    
    static func makeWeaponActionExecuteUseCase() -> WeaponActionExecuteUseCase {
        return .init(weaponStatusCheckUseCase: makeWeaponStatusCheckUseCase())
    }
}
