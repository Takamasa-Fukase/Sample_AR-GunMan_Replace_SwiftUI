//
//  WeaponObjectDataSource.swift
//
//
//  Created by ウルトラ深瀬 on 18/12/24.
//

import Foundation

final class WeaponObjectDataSource {
    static let weaponObjectDataList: [WeaponObjectData] = [
        .init(
            weaponId: 0,
            objectFilePath: "Resources/art.scnassets/Weapon/Pistol/pistol.scn",
            rootObjectName: "pistolParent",
            weaponObjectName: "pistol",
            targetHitParticleFilePath: nil,
            targetHitParticleRootObjectName: nil,
            isGunnerHandShakingAnimationEnabled: true,
            isRecoilAnimationEnabled: true
        ),
        .init(
            weaponId: 1,
            objectFilePath: "Resources/art.scnassets/Weapon/Bazooka/bazooka.scn",
            rootObjectName: "bazookaParent",
            weaponObjectName: "pistol",
            targetHitParticleFilePath: "Resources/art.scnassets/ParticleSystem/bazookaExplosion.scn",
            targetHitParticleRootObjectName: "bazookaExplosion",
            isGunnerHandShakingAnimationEnabled: false,
            isRecoilAnimationEnabled: false
        )
    ]
}
