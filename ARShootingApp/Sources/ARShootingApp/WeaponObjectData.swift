//
//  WeaponObjectData.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 18/12/24.
//

import Foundation

public struct WeaponObjectData {
    let weaponId: Int
    let objectFilePath: String
    let rootObjectName: String
    let weaponObjectName: String
    let targetHitParticleFilePath: String?
    let targetHitParticleRootObjectName: String?
    let isGunnerHandShakingAnimationEnabled: Bool
    let isRecoilAnimationEnabled: Bool
    
    public init(weaponId: Int, objectFilePath: String, rootObjectName: String, weaponObjectName: String, targetHitParticleFilePath: String?, targetHitParticleRootObjectName: String?, isGunnerHandShakingAnimationEnabled: Bool, isRecoilAnimationEnabled: Bool) {
        self.weaponId = weaponId
        self.objectFilePath = objectFilePath
        self.rootObjectName = rootObjectName
        self.weaponObjectName = weaponObjectName
        self.targetHitParticleFilePath = targetHitParticleFilePath
        self.targetHitParticleRootObjectName = targetHitParticleRootObjectName
        self.isGunnerHandShakingAnimationEnabled = isGunnerHandShakingAnimationEnabled
        self.isRecoilAnimationEnabled = isRecoilAnimationEnabled
    }
}
