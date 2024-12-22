//
//  CustomTransitionView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct CustomTransitionView<Content: View>: View {
    let onTap: (() -> Void)
    let content: Content
    @State private var backgroundColorOpacity: CGFloat = 0.0
    @State private var contentOffsetY: CGFloat = 0.0
    
    init(
        onTap: @escaping (() -> Void),
        @ViewBuilder content: () -> Content
    ) {
        self.onTap = onTap
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // 背景タップで画面を閉じる為のビュー
                Color.black
                    .opacity(backgroundColorOpacity)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture(perform: {
                        animate(isAppearing: false, geometry) {
                            onTap()
                        }
                    })
                
                content
                    .offset(y: contentOffsetY)
            }
            .onAppear {
                animate(isAppearing: true, geometry)
            }
        }
        .ignoresSafeArea()
    }
    
    func animate(isAppearing: Bool, _ geometry: GeometryProxy, completion: (() -> Void)? = nil) {
        let duration: TimeInterval = 0.2
        // 表示開始時の処理
        if isAppearing {
            contentOffsetY = geometry.size.height
            withAnimation(.linear(duration: duration)) {
                backgroundColorOpacity = 0.7
                contentOffsetY = 0
            }
        }
        // 表示終了時の処理
        else {
            withAnimation(.linear(duration: duration)) {
                backgroundColorOpacity = 0.0
                contentOffsetY = geometry.size.height
            } completion: {
                completion?()
            }
        }
    }
}

struct TestView: View {
    @State var isPresented = false
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Color.goldLeaf
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                isPresented = true
            }, label: {
                Text("show")
            })
            
            if isPresented {
                CustomTransitionView(
                    onTap: {
                        isPresented = false
                    },
                    content: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.white)
                            .frame(width: 400, height: 300)
                    }
                )
            }
        })
        .ignoresSafeArea()
    }
}

#Preview {
    CustomTransitionView(
        onTap: {
            
        },
        content: {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.white)
                .frame(width: 400, height: 300)
        }
    )
}

#Preview {
    TestView()
}
