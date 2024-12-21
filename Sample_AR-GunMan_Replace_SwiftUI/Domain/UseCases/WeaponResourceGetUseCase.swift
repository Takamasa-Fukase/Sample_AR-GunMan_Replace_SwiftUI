//
//  WeaponResourceGetUseCase.swift
//  WeaponFiringSimulator
//
//  Created by ウルトラ深瀬 on 14/11/24.
//

import Foundation

protocol WeaponResourceGetUseCaseInterface {
    func getWeaponListItems() -> [WeaponListItem]
    func getDefaultWeaponDetail() throws -> CurrentWeaponData
    func getWeaponDetail(of weaponId: Int) throws -> CurrentWeaponData
}

final class WeaponResourceGetUseCase {
    let weaponRepository: WeaponRepositoryInterface
    
    init(weaponRepository: WeaponRepositoryInterface) {
        self.weaponRepository = weaponRepository
    }
}

extension WeaponResourceGetUseCase: WeaponResourceGetUseCaseInterface {
    func getWeaponListItems() -> [WeaponListItem] {
        let weapons = weaponRepository.getAll()
        return weapons.map { weapon in
            return WeaponListItem(weaponId: weapon.id,
                                  weaponImageName: weapon.resources.weaponImageName)
        }
    }
    
    func getDefaultWeaponDetail() throws -> CurrentWeaponData {
        let weapon = try weaponRepository.getDefault()
        return CurrentWeaponData(
            id: weapon.id,
            spec: .init(
                capacity: weapon.spec.capacity,
                reloadWaitingTime: weapon.spec.reloadWaitingTime,
                reloadType: weapon.spec.reloadType,
                targetHitPoint: weapon.spec.targetHitPoint
            ),
            resources: .init(
                weaponImageName: weapon.resources.weaponImageName,
                sightImageName: weapon.resources.sightImageName,
                sightImageColorType: weapon.resources.sightImageColorType,
                bulletsCountImageBaseName: weapon.resources.bulletsCountImageBaseName,
                showingSound: weapon.resources.showingSound,
                firingSound: weapon.resources.firingSound,
                reloadingSound: weapon.resources.reloadingSound,
                outOfBulletsSound: weapon.resources.outOfBulletsSound,
                targetHitSound: weapon.resources.targetHitSound
            ),
            state: .init(
                bulletsCount: weapon.spec.capacity,
                isReloading: false
            )
        )
    }
    
    func getWeaponDetail(of weaponId: Int) throws -> CurrentWeaponData {
        let weapon = try weaponRepository.get(by: weaponId)
        return CurrentWeaponData(
            id: weapon.id,
            spec: .init(
                capacity: weapon.spec.capacity,
                reloadWaitingTime: weapon.spec.reloadWaitingTime,
                reloadType: weapon.spec.reloadType,
                targetHitPoint: weapon.spec.targetHitPoint
            ),
            resources: .init(
                weaponImageName: weapon.resources.weaponImageName,
                sightImageName: weapon.resources.sightImageName,
                sightImageColorType: weapon.resources.sightImageColorType,
                bulletsCountImageBaseName: weapon.resources.bulletsCountImageBaseName,
                showingSound: weapon.resources.showingSound,
                firingSound: weapon.resources.firingSound,
                reloadingSound: weapon.resources.reloadingSound,
                outOfBulletsSound: weapon.resources.outOfBulletsSound,
                targetHitSound: weapon.resources.targetHitSound
            ),
            state: .init(
                bulletsCount: weapon.spec.capacity,
                isReloading: false
            )
        )
    }
}
