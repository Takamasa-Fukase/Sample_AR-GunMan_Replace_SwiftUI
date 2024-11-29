//
//  WeaponObjectData.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 15/11/24.
//

import Foundation

struct WeaponObjectData {
    let weaponId: Int
    let objectFilePath: String
    let rootObjectName: String
    let weaponObjectName: String
    let targetHitParticleFilePath: String?
    let targetHitParticleRootObjectName: String?
    let isGunnerHandShakingAnimationEnabled: Bool
    let isRecoilAnimationEnabled: Bool
}
