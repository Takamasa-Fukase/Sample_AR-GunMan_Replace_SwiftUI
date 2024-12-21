//
//  CurrentWeaponData.swift
//  WeaponFiringSimulator
//
//  Created by ウルトラ深瀬 on 14/11/24.
//

import Foundation

struct CurrentWeaponData {
    let id: Int
    let spec: Spec
    let resources: Resources
    var state: State
    
    struct Spec {
        let capacity: Int
        let reloadWaitingTime: TimeInterval
        let reloadType: ReloadType
        let targetHitPoint: Int
    }
    
    struct Resources {
        let weaponImageName: String
        let sightImageName: String
        let sightImageColorType: ColorType
        let bulletsCountImageBaseName: String
        let appearingSound: SoundType
        let firingSound: SoundType
        let reloadingSound: SoundType
        let outOfBulletsSound: SoundType?
        let bulletHitSound: SoundType?
    }
    
    struct State {
        var bulletsCount: Int
        var isReloading: Bool
    }
    
    func bulletsCountImageName() -> String {
        return resources.bulletsCountImageBaseName + String(state.bulletsCount)
    }
}
