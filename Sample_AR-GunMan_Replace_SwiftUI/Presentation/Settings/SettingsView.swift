//
//  SettingsView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 17/12/24.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel = SettingsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Settings")
                .foregroundStyle(Color.blackSteel)
                .font(.custom("Copperplate Bold", size: 42))
            
            VStack(alignment: .center, spacing: 0) {
                underlineButton(title: "World Ranking", fontSize: 40) {
                    viewModel.worldRankingButtonTapped()
                }
                underlineButton(title: "Privacy Policy", fontSize: 40) {

                }
                underlineButton(title: "Contact Developer", fontSize: 40) {
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.pink)
            
            underlineButton(title: "Back", fontSize: 36) {
                viewModel.backButtonTapped()
            }
            .frame(height: 50)
        }
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 40, trailing: 30))
        .background(Color.goldLeaf)
        .onReceive(viewModel.dismiss) {
            dismiss()
        }
        .sheet(isPresented: $viewModel.isPresentedWorldRanking) {
            SettingsView()
        }
    }
    
    private func underlineButton(
        title: String,
        fontSize: CGFloat,
        onTap: @escaping (() -> Void)
    ) -> some View {
        Button {
            onTap()
        } label: {
            Text(title)
                .foregroundStyle(Color.blackSteel)
                .font(.custom("Copperplate Bold", size: fontSize))
                .underline()
//                .background(.yellow)
        }
    }
}

#Preview {
    SettingsView()
}
