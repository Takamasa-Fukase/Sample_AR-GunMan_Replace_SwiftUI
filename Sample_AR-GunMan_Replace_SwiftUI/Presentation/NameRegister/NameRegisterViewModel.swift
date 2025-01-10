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
    
    let dismiss = PassthroughSubject<Void, Never>()

    func registerButtonTapped() {
        Task {
            isRegistering = true
            await register()
            isRegistering = false
        }
    }
    
    func noButtonTapped() {
        dismiss.send(())
    }
    
    private func register() async {
        do {
            try await Task.sleep(nanoseconds: 1500000000)
            dismiss.send(())
            
        } catch {
            print("register error: \(error)")
        }
    }
}
