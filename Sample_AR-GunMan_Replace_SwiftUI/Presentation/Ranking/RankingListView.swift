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
        LazyVStack(spacing: 0) {
            Spacer()
                .frame(height: 10)
            
            ForEach(rankingList) { ranking in
                RankingListeItem(rank: 1, score: ranking.score, userName: ranking.userName)
            }
        }
    }
}

#Preview {
    CenterPreviewView(backgroundColor: .black) {
        RankingListView(rankingList: [
            .init(score: 100.00, userName: "マイケル"),
            .init(score: 99.000, userName: "マイケル")
        ])
    }
}
