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
            VStack(alignment: .trailing, spacing: 0) {
                Text("")
                    .frame(height: geometry.size.height * 0.1)
                    .frame(maxWidth: .infinity)
                    .background(.red)
                
                Image("ar_gunman_title_image", bundle: .main)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 510, height: 70)
                    .background(.blue)
                    .padding(.trailing, 40)
                    .padding(.bottom, 12)
                
                HStack(spacing: 0) {
                    Text("")
                        .frame(width: 40)
                        .frame(maxHeight: .infinity)
                        .background(.tint)
                    
                    VStack(spacing: 0) {
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
                    .frame(width: (geometry.size.width) * 0.517327)
                    .frame(maxHeight: .infinity)
                    .background(.green)
                    
                    Image("top_page_pistol_icon", bundle: .main)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.yellow)
                }
                .background(.purple)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorConst.goldLeaf)
            .sheet(isPresented: $viewModel.isGameViewPresented) {
                // ゲーム画面への遷移
                PresentationFactory.createGameView(frame: geometry.frame(in: .global))
            }
        }
        .ignoresSafeArea()
        .onAppear {
            // カメラ（ARで使用）へのアクセス許可をユーザーにリクエストするダイアログを表示
            AVCaptureDevice.requestAccess(for: .video) { _ in }
            // TODO: 後で直す
            let soundPlayer = SoundPlayer.shared
        }
        .onReceive(viewModel.playSound) { soundType in
            SoundPlayer.shared.play(soundType)
        }
        .padding(.all, 1)
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
                GeometryReader { geometry in
                    buttonImage(isIconSwitched: isIconSwitched)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.height)
                        .tint(ColorConst.blackSteel)
                }
                .frame(width: 45, height: 45)
                
                Text(title)
                    .foregroundStyle(ColorConst.blackSteel)
                    .font(.custom("Copperplate Bold", size: 50))
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.indigo)
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
