//
//  ARShootingView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI

public struct ARShootingView: UIViewRepresentable {
    private let sceneView: UIView
    
    public init(sceneView: UIView) {
        self.sceneView = sceneView
    }
    
    public func makeUIView(context: Context) -> some UIView {
        return sceneView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
