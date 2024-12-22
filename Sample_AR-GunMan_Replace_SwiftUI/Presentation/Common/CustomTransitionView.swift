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
    @State private var contentOffsetY: CGFloat = 0
    
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
                Spacer()
                    .background(.yellow)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture(perform: {
                        animate(isAppearing: false, geometry: geometry) {
                            onTap()
                        }
                    })
                
                content
                    .offset(y: contentOffsetY)
            }
            .onAppear {
                animate(isAppearing: true, geometry: geometry)
            }
        }
        .ignoresSafeArea()
        // デバッグ用なので後で消す
        .id("")
    }
    
    func animate(isAppearing: Bool, geometry: GeometryProxy, completion: (() -> Void)? = nil) {
        if isAppearing {
            contentOffsetY = geometry.size.height
            withAnimation(.linear(duration: 0.5)) {
                contentOffsetY = 0
            }
        }else {
            withAnimation(.linear(duration: 0.5)) {
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
            Color.green
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
                            .foregroundStyle(.blue)
                            .frame(width: 400, height: 300)
                    }
                )
            }
        })
    }
}

#Preview {
    CustomTransitionView(
        onTap: {
            
        },
        content: {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.blue)
                .frame(width: 400, height: 300)
        }
    )
}

#Preview {
    TestView()
}
