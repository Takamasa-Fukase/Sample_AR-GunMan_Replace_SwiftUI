//
//  RankingListView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 23/12/24.
//

import SwiftUI

struct RankingListView: View {
    var rankingList: [Ranking]
    
    var body: some View {
        if rankingList.isEmpty {
            // インジケーター
            ProgressView()
                .progressViewStyle(.circular)
                .tint(Color.paper)
                .scaleEffect(1.8)
            
        }else {
            // ランキング
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    Spacer()
                        .frame(height: 10)
                    
                    ForEach(Array(rankingList.enumerated()), id: \.offset) { (index, ranking) in
                        RankingListeItem(rank: index + 1, score: ranking.score, userName: ranking.userName)
                    }
                    
                    Spacer()
                        .frame(height: 10)
                }
            }
        }
    }
}

#Preview {
    CenterPreviewView(backgroundColor: .black) {
        RankingListView(rankingList: Array<Int>(1...100).map({
            return .init(score: Double(101 - $0), userName: "ユーザー\($0)")
        }))
    }
}
