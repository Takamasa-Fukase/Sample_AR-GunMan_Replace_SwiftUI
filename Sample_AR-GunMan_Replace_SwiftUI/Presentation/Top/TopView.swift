//
//  TopView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import SwiftUI
import AVFoundation

struct TopView: View {
    @State private var isGameViewPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                button(title: "Start") {
                    isGameViewPresented = true
                }
                button(title: "HowToPlay") {
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                // カメラ（ARで使用）へのアクセス許可をユーザーにリクエストするダイアログを表示
                AVCaptureDevice.requestAccess(for: .video) { _ in }
                // TODO: 後で直す
                let soundPlayer = SoundPlayer.shared
            }
            .sheet(isPresented: $isGameViewPresented) {
                PresentationFactory.createGameView(frame: geometry.frame(in: .global))
            }
        }
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
                .frame(width: 200, height: 60)
                .background(.tint)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    TopView()
}
