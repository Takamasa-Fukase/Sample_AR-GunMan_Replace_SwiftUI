//
//  ResultView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct ResultView: View {
    let score: Double
    let toHomeButtonTapped: (() -> Void)
    let replayButtonTapped: (() -> Void)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { safeAreaGeometry in
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 10)
                
                // 上部のタイトル部分
                titleView
                
                Spacer()
                    .frame(height: 8)
                
                // ランキングとスコア表示、ボタン表示の領域
                GeometryReader { rankingAndScoreAreaGeometry in
                    HStack(spacing: 0) {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(lineWidth: 7)
                                .padding(.all, 3.5)
                                .foregroundStyle(Color.goldLeaf)
                            
                            // ランキング
                            RankingListView(rankingList: [])
                        }
                        .frame(width: safeAreaGeometry.size.width * 0.465)
                        
                        Spacer()
                        
                        VStack(spacing: 0) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(lineWidth: 7)
                                    .padding(.all, 3.5)
                                    .foregroundStyle(Color.goldLeaf)
                                
                                Text("SCORE: \(score.scoreText)")
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(lineWidth: 7)
                                    .padding(.all, 3.5)
                                    .foregroundStyle(Color.goldLeaf)
                                
                                HStack(spacing: 0) {
                                    
                                    VStack(spacing: 0) {
                                        Button {
                                            var transaction = Transaction()
                                            transaction.disablesAnimations = true
                                            withTransaction(transaction) {
                                                dismiss()
                                            }
                                            replayButtonTapped()
                                        } label: {
                                            Text("REPLAY")
                                        }
                                        
                                        Button {
                                            toHomeButtonTapped()
                                        } label: {
                                            Text("HOME")
                                        }
                                        
                                    }
                                }
                            }
                        }
                        .frame(width: safeAreaGeometry.size.width * 0.465)
                    }
                    .padding(.all, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(lineWidth: 5)
                            .padding(.all, 2.5)
                            .foregroundStyle(Color.customDarkBrown)
                    }
                }
            }
        }
    }
    
    private var titleView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 3)
                .frame(height: 20)
                .foregroundStyle(Color.customDarkBrown)
                .overlay {
                    RoundedRectangle(cornerRadius: 1.5)
                        .stroke(lineWidth: 3)
                        .padding(.all, 1.5)
                        .foregroundStyle(Color.goldLeaf)
                }
            
            Text("WORLD RANKING")
                .font(.custom("Copperplate Bold", size: 30))
                .padding(.horizontal, 30)
                .background(
                    Color.goldLeaf
                        .frame(height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                )
                .padding(.top, 6)
        }
    }
}

#Preview {
    CenterPreviewView(backgroundColor: .black) {
        ResultView(
            score: 0.0,
            toHomeButtonTapped: {},
            replayButtonTapped: {}
        )
    }
}
