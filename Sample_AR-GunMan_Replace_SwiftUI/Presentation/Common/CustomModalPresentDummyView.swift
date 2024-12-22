//
//  CustomModalPresentDummyView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct CustomModalPresentDummyView: View {
    @State var isPresented: Bool = true
    
    var body: some View {
        Spacer()
            .showCustomModal(
                isPresented: $isPresented,
                dismissOnBackgroundTap: false,
                applyBlurEffectBackground: true
            ) { _ in
                // チュートリアル画面への遷移
                TutorialView()
                // sheetの背景を透過
                .presentationBackground(.clear)
            }
    }
}
