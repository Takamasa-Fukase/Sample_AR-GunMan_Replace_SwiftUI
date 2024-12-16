//
//  TopViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 16/12/24.
//

import Foundation
import Combine

final class TopViewModel: ObservableObject {
    enum IconButtonType {
        case start
        case settings
        case howToPlay
    }
    
    @Published var isStartButtonIconSwitched = false
    @Published var isSettingsButtonIconSwitched = false
    @Published var isHowToPlayButtonIconSwitched = false
    @Published var isGameViewPresented = false
    @Published var isSettingsViewPresented = false
    @Published var isTutorialViewPresented = false
    
    let playSound = PassthroughSubject<SoundType, Never>()

    func startButtonTapped() {
        switchButtonIconAndRevert(type: .start)
    }
    
    func settingsButtonTapped() {
        switchButtonIconAndRevert(type: .settings)
    }
    
    func howToPlayButtonTapped() {
        switchButtonIconAndRevert(type: .howToPlay)
    }
    
    private func switchButtonIconAndRevert(type: IconButtonType) {
        playSound.send(.westernPistolShoot)
        
        switch type {
        case .start:
            isStartButtonIconSwitched = true
        case .settings:
            isSettingsButtonIconSwitched = true
        case .howToPlay:
            isHowToPlayButtonIconSwitched = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            switch type {
            case .start:
                self.isStartButtonIconSwitched = false
                self.isGameViewPresented = true
                // TODO: checkCameraUsagePermissionに変える
                
            case .settings:
                self.isSettingsButtonIconSwitched = false
                self.isSettingsViewPresented = true
                
            case .howToPlay:
                self.isHowToPlayButtonIconSwitched = false
                self.isTutorialViewPresented = true
            }
        })
    }
}
