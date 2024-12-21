//
//  TutorialView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 21/12/24.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        GeometryReader { geometry in
            let scrollViewSize = scrollViewSize(safeAreaSize: geometry.size)
            
            VStack(alignment: .center, spacing: 0) {
                ContentFrameTrackableScrollView(
                    scrollDirections: .horizontal,
                    showsIndicator: false,
                    content: {
                        HStack(spacing: 0) {
                            Color.green
                                .frame(
                                    width: scrollViewSize.width,
                                    height: scrollViewSize.height
                                )
                            Color.orange
                                .frame(
                                    width: scrollViewSize.width,
                                    height: scrollViewSize.height
                                )
                            Color.blue
                                .frame(
                                    width: scrollViewSize.width,
                                    height: scrollViewSize.height
                                )
                        }
                    },
                    onScroll: { frame in
                        
                    }
                )
                .scrollTargetBehavior(.paging)
                .frame(
                    width: scrollViewSize.width,
                    height: scrollViewSize.height
                )
                .clipped()
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func scrollViewSize(safeAreaSize: CGSize) -> CGSize {
        return .init(
            width: safeAreaSize.height * 0.685 * 1.33,
            height: safeAreaSize.height * 0.685
        )
    }
    
    private func scrollViewItem(scrollViewSize: CGSize) -> some View {
        Spacer()
            .frame(
                width: scrollViewSize.width,
                height: scrollViewSize.height
            )
    }
}

#Preview {
    TutorialView()
}
