//
//  TopView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import SwiftUI
import Foundation
import AVFoundation

struct TopView: View {
    @StateObject var viewModel = TopViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                targetIconButton(title: "Start", isIconSwitched: viewModel.isStartButtonIconSwitched) {
                    viewModel.startButtonTapped()
                }
                targetIconButton(title: "Settings", isIconSwitched: viewModel.isSettingsButtonIconSwitched) {
                    viewModel.settingsButtonTapped()
                }
                targetIconButton(title: "HowToPlay", isIconSwitched: viewModel.isHowToPlayButtonIconSwitched) {
                    viewModel.howToPlayButtonTapped()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                // カメラ（ARで使用）へのアクセス許可をユーザーにリクエストするダイアログを表示
                AVCaptureDevice.requestAccess(for: .video) { _ in }
                // TODO: 後で直す
                let soundPlayer = SoundPlayer.shared
            }
            .sheet(isPresented: $viewModel.isGameViewPresented) {
                PresentationFactory.createGameView(frame: geometry.frame(in: .global))
            }
        }
        .background(ColorConst.goldLeaf)
        .onReceive(viewModel.playSound) { soundType in
            SoundPlayer.shared.play(soundType)
        }
    }
    
    private func targetIconButton(
        title: String,
        isIconSwitched: Bool,
        onTap: @escaping (() -> Void)
    ) -> some View {
        Button {
            onTap()
        } label: {
            HStack(alignment: .center, spacing: 8) {
                buttonImage(isIconSwitched: isIconSwitched)
                    .frame(width: 45, height: 45)
                    .tint(ColorConst.blackSteel)
                
                Text(title)
                    .foregroundStyle(ColorConst.blackSteel)
                    .frame(alignment: .leading)
                    .font(.custom("Copperplate Bold", size: 50))
                
                Spacer()
            }
        }
    }
    
    private func buttonImage(isIconSwitched: Bool) -> some View {
        if isIconSwitched {
            Image("bullets_hole", bundle: .main)
                .resizable()
        }else {
            Image(systemName: "target")
                .resizable()
        }
    }
}

#Preview {
    TopView()
}
