//
//  ResultView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct ResultView: View {
    let viewModel = ResultViewModel()
    let score: Double
    let toHomeButtonTapped: (() -> Void)
    let replayButtonTapped: (() -> Void)
    @Environment(\.dismiss) var dismiss
    @State var isButtonsBaseViewVisible = false
    @State var buttonsOpacity = 0.0
    
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
                            // ランキング
                            RankingListView(rankingList: viewModel.rankingList)
                            
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(lineWidth: 7)
                                .padding(.all, 3.5)
                                .foregroundStyle(Color.goldLeaf)
                        }
                        .frame(width: safeAreaGeometry.size.width * 0.465)
                        .clipped()
                        
                        Spacer()
                        
                        VStack(spacing: 0) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 1)
                                    .stroke(lineWidth: 7)
                                    .padding(.all, 3.5)
                                    .foregroundStyle(Color.goldLeaf)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("SCORE")
                                        .font(.custom("Copperplate", size: 22))
                                        .frame(width: 75, height: 23)
                                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 0))
                                        .minimumScaleFactor(0.5) // 最大50%までは縮小を許可する
                                    
                                    Text("\(score.scoreText)")
                                        .font(.custom("Copperplate Bold", size: 80))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .minimumScaleFactor(0.5) // 最大50%までは縮小を許可する
                                        .padding(.bottom, 5)
                                }
                            }
                            .frame(height: (rankingAndScoreAreaGeometry.size.height - 20) * 0.33125)
                            
                            Spacer()
                                .frame(height: 6)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 1)
                                    .stroke(lineWidth: 7)
                                    .padding(.all, 3.5)
                                    .foregroundStyle(Color.goldLeaf)
                                
                                GeometryReader { actionButtonsAreaGeometry in
                                    HStack(spacing: 0) {
                                        Image("pistol")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: actionButtonsAreaGeometry.size.width * 0.62)
                                        
                                        if isButtonsBaseViewVisible {
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
                                                        .font(.custom("Copperplate Bold", size: 25))
                                                        .frame(maxHeight: .infinity)
                                                        .opacity(buttonsOpacity)
                                                }
                                                
                                                Button {
                                                    toHomeButtonTapped()
                                                } label: {
                                                    Text("HOME")
                                                        .font(.custom("Copperplate Bold", size: 25))
                                                        .frame(maxHeight: .infinity)
                                                        .opacity(buttonsOpacity)
                                                }
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .padding(.all, 20)
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
                .foregroundStyle(Color.paper)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .task {
            await viewModel.getRanking()
            await viewModel.nameRegisterViewClosed()
        }
        .onReceive(viewModel.showButtons, perform: { _ in
            withAnimation(.linear(duration: 0.6)) {
                isButtonsBaseViewVisible = true
            } completion: {
                withAnimation(.linear(duration: 0.2)) {
                    buttonsOpacity = 1
                }
            }
        })
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
            score: 98.765,
            toHomeButtonTapped: {},
            replayButtonTapped: {}
        )
    }
}
