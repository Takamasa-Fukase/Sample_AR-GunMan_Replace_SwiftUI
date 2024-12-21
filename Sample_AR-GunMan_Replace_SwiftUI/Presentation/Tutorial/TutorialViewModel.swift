//
//  TutorialViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 21/12/24.
//

import Foundation
import Observation
import Combine

final class TutorialViewModel {
    let contents: [TutorialContent] = TutorialConst.contents
    private(set) var currentPageIndex: Int = 0
    private(set) var buttonTitle: String = "NEXT"
    
    let scrollToPageIndex = PassthroughSubject<Int, Never>()
    let dismiss = PassthroughSubject<Void, Never>()
    
    func onScroll(_ frame: CGRect) {
        
    }
    
    func buttonTapped() {
        if currentPageIndex == 2 {
            dismiss.send(Void())
        }else {
            scrollToPageIndex.send(currentPageIndex + 1)
        }
    }
}
