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
                targetHitPoint: 5
            ),
            resources: .init(
                weaponImageName: "pistol",
                sightImageName: "pistol_sight",
                sightImageColorType: .red,
                bulletsCountImageBaseName: "pistol_bullets_",
                showingSound: .pistolSet,
                firingSound: .pistolShoot,
                reloadingSound: .pistolReload,
                outOfBulletsSound: .pistolOutBullets,
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
                targetHitPoint: 12
            ),
            resources: .init(
                weaponImageName: "bazooka",
                sightImageName: "bazooka_sight",
                sightImageColorType: .green,
                bulletsCountImageBaseName: "bazooka_bullets_",
                showingSound: .bazookaSet,
                firingSound: .bazookaShoot,
                reloadingSound: .bazookaReload,
                outOfBulletsSound: nil,
                targetHitSound: .bazookaHit
            )
        )
    ]
}
