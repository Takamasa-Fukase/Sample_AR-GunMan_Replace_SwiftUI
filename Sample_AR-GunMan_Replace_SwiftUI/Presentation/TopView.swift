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
        VStack(spacing: 16) {
            button(title: "Start") {
                isGameViewPresented = true
            }
            button(title: "HowToPlay") {
                
            }
        }
        .onAppear {
            // カメラ（ARで使用）へのアクセス許可をユーザーにリクエストするダイアログを表示
            AVCaptureDevice.requestAccess(for: .video) { _ in }
        }
        .sheet(isPresented: $isGameViewPresented) {
            PresentationFactory.createGameView()
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
