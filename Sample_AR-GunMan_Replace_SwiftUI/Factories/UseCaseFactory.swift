//
//  UseCaseFactory.swift
//
//
//  Created by ウルトラ深瀬 on 21/11/24.
//

import Foundation

final class UseCaseFactory {
    static func create() -> WeaponResourceGetUseCaseInterface {
        return WeaponResourceGetUseCase(weaponRepository: RepositoryFactory.create())
    }
    
    static func create() -> WeaponStatusCheckUseCaseInterface {
        return WeaponStatusCheckUseCase()
    }
    
    static func create() -> WeaponActionExecuteUseCaseInterface {
        return WeaponActionExecuteUseCase(weaponStatusCheckUseCase: create())
    }
}
