//
//  WeaponRepository.swift
//  WeaponFiringSimulator
//
//  Created by ウルトラ深瀬 on 6/11/24.
//

import Foundation

final class WeaponRepository: WeaponRepositoryInterface {
    private let weapons: [Weapon] = WeaponDataSource.weapons
    
    func get(by id: Int) throws -> Weapon {
        guard let weapon = weapons.first(where: { $0.id == id }) else {
            //　エラーをthrowする
            throw CustomError.other(message: "武器が存在しません id: \(id)")
        }
        return weapon
    }
    
    func getDefault() throws -> Weapon {
        guard let weapon = weapons.first(where: { $0.isDefault }) else {
            //　エラーをthrowする
            throw CustomError.other(message: "デフォルトの武器が存在しません")
        }
        return weapon
    }
    
    func getAll() -> [Weapon] {
        return weapons
    }
}
