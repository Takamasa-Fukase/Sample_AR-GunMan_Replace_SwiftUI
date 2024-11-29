//
//  RepositoryProvider.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 19/11/24.
//

import Foundation

final class RepositoryProvider {
    static func makeWeaponRepository() -> WeaponRepository {
        return .init()
    }
    
    static func makeTutorialRepository() -> TutorialRepository {
        return .init()
    }
}
