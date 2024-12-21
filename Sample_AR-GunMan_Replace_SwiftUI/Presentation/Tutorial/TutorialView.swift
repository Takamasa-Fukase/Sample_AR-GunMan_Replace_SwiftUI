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
                Spacer()
                    .frame(height: 20)
                
                ContentFrameTrackableScrollView(
                    scrollDirections: .horizontal,
                    showsIndicator: false,
                    content: {
                        HStack(spacing: 0) {
                            ForEach(TutorialConst.contents) { content in
                                TutorialScrollViewItem(content: content)
                                    .frame(
                                        width: scrollViewSize.width,
                                        height: scrollViewSize.height
                                    )
                            }
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
                .background(.white)
                
                Spacer()
                    .frame(height: 30)
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.goldLeaf.opacity(0.7))
                        .frame(width: 150, height: 65, alignment: .center)
                        .overlay {
                            Text("NEXT")
                                .font(.custom("Copperplate Bold", size: 25))
                                .foregroundStyle(Color.blackSteel)
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.customDarkBrown, lineWidth: 1)
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black.opacity(0.4))
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
