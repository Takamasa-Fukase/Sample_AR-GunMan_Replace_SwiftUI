//
//  WeaponDetailData.swift
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
        let isGunnerHandShakingAnimationEnabled: Bool
        let isRecoilAnimationEnabled: Bool
        let targetHitPoint: Int
    }
    
    struct Resources {
        let weaponImageName: String
        let sightImageName: String
        let sightImageColorType: ColorType
        let bulletsCountImageBaseName: String
        let objectFilePath: String
        let rootObjectName: String
        let weaponObjectName: String
        let targetHitParticleFilePath: String?
        let targetHitParticleRootObjectName: String?
        let showingSound: SoundType
        let firingSound: SoundType
        let reloadingSound: SoundType
        let noBulletsSound: SoundType?
        let targetHitSound: SoundType?
    }
    
    struct State {
        var bulletsCount: Int
        var isReloading: Bool
    }
    
    func bulletsCountImageName() -> String {
        return resources.bulletsCountImageBaseName + String(state.bulletsCount)
    }
    
    func extractWeaponObjectData() -> WeaponObjectData {
        return .init(
            weaponId: id,
            objectFilePath: resources.objectFilePath,
            rootObjectName: resources.rootObjectName,
            weaponObjectName: resources.weaponObjectName,
            targetHitParticleFilePath: resources.targetHitParticleFilePath,
            targetHitParticleRootObjectName: resources.targetHitParticleRootObjectName,
            isGunnerHandShakingAnimationEnabled: spec.isGunnerHandShakingAnimationEnabled,
            isRecoilAnimationEnabled: spec.isRecoilAnimationEnabled
        )
    }
}
