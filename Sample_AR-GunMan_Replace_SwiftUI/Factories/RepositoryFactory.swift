//
//  RepositoryFactory.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 19/11/24.
//

import Foundation
import DataLayer
import DomainLayer

final class RepositoryFactory {
    public init() {}

    static func create() -> WeaponRepositoryInterface {
        return WeaponRepository()
    }
    
    static func create() -> TutorialRepositoryInterface {
        return TutorialRepository()
    }
    
    static func create() -> PermissionRepositoryInterface {
        return PermissionRepository()
    }
    
    static func create() -> RankingRepositoryInterface {
        return RankingRepositoryStub()
    }
}
