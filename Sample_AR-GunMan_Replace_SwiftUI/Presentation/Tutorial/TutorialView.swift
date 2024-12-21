//
//  TutorialView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 21/12/24.
//

import SwiftUI

struct TutorialView: View {
    let viewModel = TutorialViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            let scrollViewSize = scrollViewSize(safeAreaSize: geometry.size)
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(height: 20)
                
                ScrollViewReader { proxy in
                    // 横向きのスクロールビュー（PagerView的な）
                    ContentFrameTrackableScrollView(
                        scrollDirections: .horizontal,
                        showsIndicator: false,
                        content: {
                            HStack(spacing: 0) {
                                ForEach(Array(viewModel.contents.enumerated()), id: \.offset) { index, content in
                                    TutorialScrollViewItem(content: content)
                                        .id(index) // 指定したページにスクロールできる様に識別idを付与
                                        .frame(
                                            width: scrollViewSize.width,
                                            height: scrollViewSize.height
                                        )
                                }
                            }
                        },
                        onScroll: { contentFrame in
                            viewModel.onScroll(contentFrame)
                        }
                    )
                    // ページング可能にする（ピッタリ止まる）
                    .scrollTargetBehavior(.paging)
                    .frame(
                        width: scrollViewSize.width,
                        height: scrollViewSize.height
                    )
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.goldLeaf, lineWidth: 5)
                    }
                    .onReceive(viewModel.scrollToPageIndex) { pageIndex in
                        // 受け取ったpageIndexまでアニメーション付きでスクロールさせる
                        withAnimation {
                            proxy.scrollTo(pageIndex)
                        }
                    }
                }
                
                // ページコントロール
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<viewModel.contents.count, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundStyle(
                                index == viewModel.currentPageIndex ? Color.paper : Color(.lightGray)
                            )
                            .clipped()
                            .padding(.all, 4)
                    }
                }
                .frame(height: 30)
                
                // 画面下部のボタン（NEXT or OK）
                Button {
                    viewModel.buttonTapped()
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.goldLeaf)
                        .frame(width: 150, height: 65, alignment: .center)
                        .overlay {
                            Text(viewModel.buttonTitle)
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
        .onReceive(viewModel.dismiss) { _ in
            dismiss()
        }
    }
    
    private func scrollViewSize(safeAreaSize: CGSize) -> CGSize {
        return .init(
            width: safeAreaSize.height * 0.685 * 1.33,
            height: safeAreaSize.height * 0.685
        )
    }
}

#Preview {
    TutorialView()
}
