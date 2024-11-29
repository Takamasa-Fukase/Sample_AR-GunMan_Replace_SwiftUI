//
//  GameViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import Foundation

final class GameViewModel: ObservableObject {
    @Published var timeCount: Double = 30.00
    @Published var bulletsCount: Int = 7
    @Published var isReloading = false
    
    
}
