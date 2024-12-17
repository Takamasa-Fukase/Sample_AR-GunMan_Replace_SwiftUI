//
//  SettingsViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 17/12/24.
//

import Foundation
import Observation
import Combine

@Observable
final class SettingsViewModel {
    var isPresentedWorldRanking = false
    
    let dismiss = PassthroughSubject<Void, Never>()
    
    func worldRankingButtonTapped() {
        isPresentedWorldRanking = true
    }
    
    func backButtonTapped() {
        dismiss.send(Void())
    }
}
