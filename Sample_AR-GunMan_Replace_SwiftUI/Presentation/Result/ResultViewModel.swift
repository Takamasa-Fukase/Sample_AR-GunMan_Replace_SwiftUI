//
//  ResultViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 9/1/25.
//

import Foundation
import Observation
import Combine

@Observable
final class ResultViewModel {
    let score: Double
    private(set) var rankingList: [Ranking] = []
    var isNameRegisterViewPresented = false
    
    let showButtons = PassthroughSubject<Void, Never>()
    let dismissAndNotifyReplayButtonTap = PassthroughSubject<Void, Never>()
    let notifyHomeButtonTap = PassthroughSubject<Void, Never>()
    
    private let rankingRepository: RankingRepositoryInterface
    
    init(
        rankingRepository: RankingRepositoryInterface,
        score: Double
    ) {
        self.rankingRepository = rankingRepository
        self.score = score
    }
    
    func onViewAppear() {
        executeSimultaneously()
    }
    
    func rankingRegistered() {
        // TODO: 渡されたRankingを、該当のindex（既に算出して保持済みの想定）位置に挿入し、中央位置にスクロールさせる
        
    }
    
    func nameRegisterViewClosed() {
        showButtons.send(())
    }
    
    func replayButtonTapped() {
        dismissAndNotifyReplayButtonTap.send(())
    }
    
    func toHomeButtonTapped() {
        notifyHomeButtonTap.send(())
    }
    
    private func executeSimultaneously() {
        print("executeSimultaneously")
        Task {
            _ = await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    do {
                        // 0.5秒後に名前登録ダイアログを表示する
                        try await Task.sleep(nanoseconds: 500000000)
                        self.isNameRegisterViewPresented = true
                        print("self.isNameRegisterViewPresented = true")
                        
                    } catch {
                        print("showNameRegisterView error: \(error)")
                    }
                }
                group.addTask {
                    do {
                        self.rankingList = try await self.rankingRepository.getRanking()
                        print("self.rankingList = try await self.rankingRepository.getRanking()")

                    } catch {
                        print("getRanking error: \(error)")
                    }
                }
            }
        }
    }
}
