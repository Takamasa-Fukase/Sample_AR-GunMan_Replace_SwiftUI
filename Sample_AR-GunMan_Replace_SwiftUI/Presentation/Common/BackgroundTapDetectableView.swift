//
//  BackgroundTapDetectableView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct BackgroundTapDetectableView<Content: View>: View {
    let backgroundColor: Color
    let onTap: (() -> Void)
    let content: Content
    
    init(
        backgroundColor: Color,
        onTap: @escaping (() -> Void),
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.onTap = onTap
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            // 背景タップで画面を閉じる為のビュー
            backgroundColor
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture(perform: onTap)
            
            content
        }
    }
}
