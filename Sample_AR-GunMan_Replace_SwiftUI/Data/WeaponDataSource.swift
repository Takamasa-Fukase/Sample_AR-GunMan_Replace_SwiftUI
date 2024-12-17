//
//  WeaponDataSource.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 15/11/24.
//

import Foundation

final class WeaponDataSource {
    static let weapons: [Weapon] = [
        .init(
            id: 0,
            isDefault: true,
            spec: .init(
                capacity: 7,
                reloadWaitingTime: 0,
                reloadType: .manual,
                isGunnerHandShakingAnimationEnabled: true,
                isRecoilAnimationEnabled: true,
                targetHitPoint: 5
            ),
            resources: .init(
                weaponImageName: "pistol",
                sightImageName: "pistol_sight",
                sightImageColorType: .red,
                bulletsCountImageBaseName: "pistol_bullets_",
                objectFilePath: "Resources/art.scnassets/Weapon/Pistol/pistol.scn",
                rootObjectName: "pistolParent",
                weaponObjectName: "pistol",
                targetHitParticleFilePath: nil,
                targetHitParticleRootObjectName: nil,
                showingSound: .pistolSet,
                firingSound: .pistolShoot,
                reloadingSound: .pistolReload,
                noBulletsSound: .pistolOutBullets,
                targetHitSound: nil
            )
        ),
        .init(
            id: 1,
            isDefault: false,
            spec: .init(
                capacity: 1,
                reloadWaitingTime: 3.2,
                reloadType: .auto,
                isGunnerHandShakingAnimationEnabled: false,
                isRecoilAnimationEnabled: false,
                targetHitPoint: 12
            ),
            resources: .init(
                weaponImageName: "bazooka",
                sightImageName: "bazooka_sight",
                sightImageColorType: .green,
                bulletsCountImageBaseName: "bazooka_bullets_",
                objectFilePath: "Resources/art.scnassets/Weapon/Bazooka/bazooka.scn",
                rootObjectName: "bazookaParent",
                weaponObjectName: "pistol",
                targetHitParticleFilePath: "Resources/art.scnassets/ParticleSystem/bazookaExplosion.scn",
                targetHitParticleRootObjectName: "bazookaExplosion",
                showingSound: .bazookaSet,
                firingSound: .bazookaShoot,
                reloadingSound: .bazookaReload,
                noBulletsSound: nil,
                targetHitSound: .bazookaHit
            )
        )
    ]
}
