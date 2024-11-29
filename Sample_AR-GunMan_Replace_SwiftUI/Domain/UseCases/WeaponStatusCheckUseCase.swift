//
//  WeaponStatusCheckUseCase.swift
//  WeaponFiringSimulator
//
//  Created by ウルトラ深瀬 on 14/11/24.
//

import Foundation

protocol WeaponStatusCheckUseCaseInterface {
    func checkCanFire(bulletsCount: Int,
                      isReloading: Bool) -> Bool
    func checkCanReload(bulletsCount: Int,
                        isReloading: Bool) -> Bool
    func checkNeedsAutoReload(bulletsCount: Int,
                              isReloading: Bool,
                              reloadType: ReloadType) -> Bool
}

final class WeaponStatusCheckUseCase: WeaponStatusCheckUseCaseInterface {
    func checkCanFire(bulletsCount: Int, isReloading: Bool) -> Bool {
        if isReloading { return false }
        if bulletsCount > 0 {
            return true
        }else {
            return false
        }
    }
    
    func checkCanReload(bulletsCount: Int, isReloading: Bool) -> Bool {
        if isReloading { return false }
        if bulletsCount <= 0 {
            return true
        }else {
            return false
        }
    }
    
    func checkNeedsAutoReload(bulletsCount: Int, isReloading: Bool, reloadType: ReloadType) -> Bool {
        if isReloading { return false }
        if bulletsCount == 0 && reloadType == .auto {
            return true
        }else {
            return false
        }
    }
}
