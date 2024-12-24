//
//  RankingViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 25/12/24.
//

import Foundation
import Observation
import Combine

@Observable
final class RankingViewModel {
    private(set) var rankingList: [Ranking] = []
    
    let dismiss = PassthroughSubject<Void, Never>()
    
    func getRanking() async {
        do {
            try await Task.sleep(nanoseconds: 1500000000)
            
            rankingList = Array<Int>(1...100).map({
                return .init(score: Double(101 - $0), userName: "ユーザー\($0)")
            })
        } catch {
            print("getRanking error: \(error)")
        }
    }
    
    func closeButtonTapped() {
        dismiss.send(())
    }
}
