//
//  GameView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import SwiftUI

struct GameView: View {
    @State var timeCount: Double = 30.00
    @State var bulletsCount: Int = 7
    @State var isReloading = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(timeCount.timeCountText)
                    .font(.system(size: 32))
                    .frame(width: 120, height: 60, alignment: .center)
                    .foregroundStyle(Color(.systemBackground))
                    .background(Color(.label))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
                
                Button {
                    //TODO: 武器選択画面を表示
                    
                } label: {
                    Image("weapon_change")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            
            Image("pistol_sight")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)

            
            HStack(alignment: .bottom, spacing: 0) {
                Image("pistol_bullets_\(bulletsCount)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 80, alignment: .bottom)
                
                Spacer()
                
                VStack(spacing: 16) {
                    button(title: "Fire") {
                        
                    }
                    button(title: "Reload") {
                        
                    }
                }
            }
        }
        // TODO: 謎だが一旦急ぎなので下記の暫定対応にしておく。
        // landscapeだと左右のSafeAreaが考慮されずに謎の伸びが発生してレイアウトがおかしくなっている
        .padding([.leading, .trailing], 1)
    }
    
    private func button(
        title: String,
        onTap: @escaping (() -> Void)
    ) -> some View {
        Button {
            onTap()
        } label: {
            Text(title)
                .foregroundStyle(Color(.label))
                .frame(width: 80, height: 40)
                .background(.tint)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    GameView()
}
