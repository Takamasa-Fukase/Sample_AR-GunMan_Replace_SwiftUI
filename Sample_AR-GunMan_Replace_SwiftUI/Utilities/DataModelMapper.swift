//
//  DataModelMapper.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 18/12/24.
//

import Foundation
import ARShootingApp

final class DataModelMapper {
    static func convertDomainWeaponObjectDataForARShootingApp(
        _ modelData: WeaponObjectData
    ) -> ARShootingApp.WeaponObjectData {
        return ARShootingApp.WeaponObjectData(
            weaponId: modelData.weaponId,
            objectFilePath: modelData.objectFilePath,
            rootObjectName: modelData.rootObjectName,
            weaponObjectName: modelData.weaponObjectName,
            targetHitParticleFilePath: modelData.targetHitParticleFilePath,
            targetHitParticleRootObjectName: modelData.targetHitParticleRootObjectName,
            isGunnerHandShakingAnimationEnabled: modelData.isGunnerHandShakingAnimationEnabled,
            isRecoilAnimationEnabled: modelData.isRecoilAnimationEnabled
        )
    }
}
