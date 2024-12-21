//
//  Weapon.swift
//  WeaponFiringSimulator
//
//  Created by ウルトラ深瀬 on 5/11/24.
//

import Foundation

enum ColorType {
    case red
    case green
}

enum ReloadType {
    case manual
    case auto
}

struct Weapon {
    let id: Int
    let isDefault: Bool
    let spec: Spec
    let resources: Resources
    
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
}
