//
//  TutorialUseCase.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 15/11/24.
//

import Foundation

protocol TutorialUseCaseInterface {
    func checkCompletedFlag() -> Bool
    func updateCompletedFlag(isCompleted: Bool)
}

final class TutorialUseCase {
    private let tutorialRepository: TutorialRepositoryInterface
    
    init(tutorialRepository: TutorialRepositoryInterface) {
        self.tutorialRepository = tutorialRepository
    }
}

extension TutorialUseCase: TutorialUseCaseInterface {
    func checkCompletedFlag() -> Bool {
        return tutorialRepository.getTutorialCompletedFlag()
    }
    
    func updateCompletedFlag(isCompleted: Bool) {
        tutorialRepository.updateTutorialCompletedFlag(isCompleted: isCompleted)
    }
}
