//
//  WeaponSelectViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 19/12/24.
//

import Foundation
import Observation

@Observable
final class WeaponSelectViewModel {
    var weaponListItems = [WeaponListItem]()
    private var weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface
    
    init(weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface) {
        self.weaponResourceGetUseCase = weaponResourceGetUseCase
    }
    
    func onViewAppear() {
        let items = weaponResourceGetUseCase.getWeaponListItems()
        weaponListItems = Array(repeating: items, count: 8).flatMap({ $0 })
    }
}
