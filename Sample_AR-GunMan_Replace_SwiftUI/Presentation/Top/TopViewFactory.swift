//
//  TopViewFactory.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 19/12/24.
//

import Foundation

final class TopViewFactory {
    static func create() -> TopView {
        return TopView(viewModel: TopViewModel())
    }
}
