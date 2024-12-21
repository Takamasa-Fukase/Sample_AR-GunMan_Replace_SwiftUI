//
//  WeaponActionExecuteUseCase.swift
//  WeaponFiringSimulator
//
//  Created by ウルトラ深瀬 on 14/11/24.
//

import Foundation

protocol WeaponActionExecuteUseCaseInterface {
    func fireWeapon(bulletsCount: Int,
                    isReloading: Bool,
                    reloadType: ReloadType,
                    onFired: ((WeaponFireCompletedResponse) -> Void),
                    onOutOfBullets: (() -> Void))
    func reloadWeapon(bulletsCount: Int,
                      isReloading: Bool,
                      capacity: Int,
                      reloadWaitingTime: TimeInterval,
                      onReloadStarted: ((WeaponReloadStartedResponse) -> Void),
                      onReloadEnded: @escaping ((WeaponReloadEndedResponse) -> Void))
}

struct WeaponFireCompletedResponse {
    let bulletsCount: Int
    let needsAutoReload: Bool
}

struct WeaponReloadStartedResponse {
    let isReloading: Bool
}

struct WeaponReloadEndedResponse {
    let bulletsCount: Int
    let isReloading: Bool
}

final class WeaponActionExecuteUseCase {
    private let weaponStatusCheckUseCase: WeaponStatusCheckUseCaseInterface
    
    init(weaponStatusCheckUseCase: WeaponStatusCheckUseCaseInterface) {
        self.weaponStatusCheckUseCase = weaponStatusCheckUseCase
    }
}

extension WeaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface {
    func fireWeapon(bulletsCount: Int, isReloading: Bool, reloadType: ReloadType, onFired: ((WeaponFireCompletedResponse) -> Void), onOutOfBullets: (() -> Void)) {
        let canFire = weaponStatusCheckUseCase.checkCanFire(bulletsCount: bulletsCount, isReloading: isReloading)
        
        let decrementedBulletsCount = bulletsCount - 1
        
        if canFire {
            let needsAutoReload = weaponStatusCheckUseCase.checkNeedsAutoReload(bulletsCount: decrementedBulletsCount, isReloading: isReloading, reloadType: reloadType)
            
            let completedReponse = WeaponFireCompletedResponse(bulletsCount: decrementedBulletsCount, needsAutoReload: needsAutoReload)
            onFired(completedReponse)
            
        }else {
            onOutOfBullets()
        }
    }
    
    func reloadWeapon(bulletsCount: Int, isReloading: Bool, capacity: Int, reloadWaitingTime: TimeInterval, onReloadStarted: ((WeaponReloadStartedResponse) -> Void), onReloadEnded: @escaping ((WeaponReloadEndedResponse) -> Void)) {
        let canReload = weaponStatusCheckUseCase.checkCanReload(bulletsCount: bulletsCount, isReloading: isReloading)
        
        let refilledBulletsCount = capacity

        if canReload {
            let startedResponse = WeaponReloadStartedResponse(isReloading: true)
            onReloadStarted(startedResponse)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + reloadWaitingTime, execute: {
                let endedResponse = WeaponReloadEndedResponse(
                    bulletsCount: refilledBulletsCount,
                    isReloading: false
                )
                onReloadEnded(endedResponse)
            })
        }
    }
}
