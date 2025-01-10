//
//  RankingRepositoryInterface.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 10/1/25.
//

import Foundation

protocol RankingRepositoryInterface {
    func getRanking() async throws -> [Ranking]
    func registerRanking(_ ranking: Ranking) async throws
}
