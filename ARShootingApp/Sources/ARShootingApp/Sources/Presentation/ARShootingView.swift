//
//  ARShootingView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI

struct ARShootingView: UIViewRepresentable {
    private let sceneView: UIView
    
    init(sceneView: UIView) {
        self.sceneView = sceneView
    }
    
    func makeUIView(context: Context) -> some UIView {
        return sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
