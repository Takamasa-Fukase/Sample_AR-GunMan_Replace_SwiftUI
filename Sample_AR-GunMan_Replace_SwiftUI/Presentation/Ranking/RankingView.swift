//
//  RankingView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 23/12/24.
//

import SwiftUI

struct RankingView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    ZStack {
                        Color.goldLeaf
                            .frame(height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        Text("WORLD RANKING")
                            .font(.custom("Copperplate Bold", size: 30))
                        HStack {
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .tint(.blackSteel)
                                    .font(.system(size: 17, weight: .bold))
                                    .frame(width: 60)
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.6)
                .padding(EdgeInsets(top: 24, leading: 0, bottom: 30, trailing: 0))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray)
        }
    }
}

#Preview {
    RankingView()
}
