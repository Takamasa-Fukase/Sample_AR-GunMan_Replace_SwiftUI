//
//  TutorialRepository.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 11/11/24.
//

import Foundation

final class TutorialRepository: TutorialRepositoryInterface {
    func getTutorialCompletedFlag() -> Bool {
        return UserDefaults.isTutorialCompleted
    }
    
    func updateTutorialCompletedFlag(isCompleted: Bool) {
        UserDefaults.isTutorialCompleted = isCompleted
    }
}
