//
//  NameRegisterViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 9/1/25.
//

import Foundation
import Observation
import Combine

@Observable
final class NameRegisterViewModel {
    private(set) var rankText = ""
    private(set) var isRegistering = false
    private(set) var isRegisterButtonEnabled = false
    var nameText = "" {
        didSet {
            isRegisterButtonEnabled = !nameText.isEmpty
        }
    }
    
    let notifyRegistrationCompletion = PassthroughSubject<Ranking, Never>()
    let dismiss = PassthroughSubject<Void, Never>()
    
    private let score: Double
    
    init(score: Double) {
        self.score = score
    }
    
    func onViewDisappear() {
        
    }

    func registerButtonTapped() {
        Task {
            let ranking = Ranking(score: score, userName: nameText)
            
            isRegistering = true
            do {
                try await Task.sleep(nanoseconds: 1500000000)
                notifyRegistrationCompletion.send(ranking)
                dismiss.send(())
                
            } catch {
                print("register error: \(error)")
                // TODO: エラーをアラート表示
            }
            isRegistering = false
        }
    }
    
    func noButtonTapped() {
        dismiss.send(())
    }
}
