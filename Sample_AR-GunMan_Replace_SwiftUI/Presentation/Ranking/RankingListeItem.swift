//
//  RankingListeItem.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 23/12/24.
//

import SwiftUI

struct RankingListeItem: View {
    var rank: Int
    var score: Double
    var userName: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 背景1
            Color.customDarkBrown
                .frame(maxWidth: .infinity)
                .border(Color.goldLeaf, width: 4)
            
            // 四隅の白い点
            whiteCornerSquares
                .padding(EdgeInsets(top: 8, leading: 2, bottom: 8, trailing: 2))
            
            // 背景2
            Color.customLightBrown
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
            
            HStack(alignment: .bottom, spacing: 0) {
                // 順位
                Text(String(rank))
                    .font(.custom("Copperplate Bold", size: 22))
                    .frame(width: 32, height: 22)
                    .background(Color.goldLeaf)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 4, trailing: 0))
                
                // スコア
                Text(score.scoreText)
                    .font(.custom("Copperplate", size: 22))
                    .frame(alignment: .centerLastTextBaseline)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 10))
                
                // ユーザー名
                Text(userName)
                    .font(.custom("Copperplate Bold", size: 38))
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: .infinity, alignment: .leadingLastTextBaseline)
                    .padding(.bottom, 10)
            }
        }
        .foregroundStyle(.white)
        .padding(EdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 16))
//        .frame(height: 40)
    }
    
    private var whiteCornerSquares: some View {
        VStack {
            HStack {
                Color.paper
                    .frame(width: 4, height: 2)
                
                Spacer()
                
                Color.paper
                    .frame(width: 4, height: 2)
            }
            
            Spacer()
            
            HStack {
                Color.paper
                    .frame(width: 4, height: 2)
                
                Spacer()
                
                Color.paper
                    .frame(width: 4, height: 2)
            }
        }
    }
}

#Preview {
    CenterPreviewView(backgroundColor: .black) {
        VStack(alignment: .center, spacing: 0) {
            RankingListeItem(rank: 1, score: 100.00, userName: "マイケル")
            RankingListeItem(rank: 2, score: 99.000, userName: "マイケル")
            RankingListeItem(rank: 3, score: 98.000, userName: "マイケル")
            RankingListeItem(rank: 4, score: 97.000, userName: "マイケルaaa")
            RankingListeItem(rank: 5, score: 96.000, userName: "マイケルaaaaa")
            RankingListeItem(rank: 6, score: 95.000, userName: "マイケルaaaaaaaaaaaaaaaa")
        }
        .frame(width: 400, height: 300)
    }
}
