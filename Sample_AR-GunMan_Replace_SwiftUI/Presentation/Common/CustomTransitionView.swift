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
    @State private var isBackgroundViewHidden = true
    @State private var contentOffsetY: CGFloat = 0
    @State var isAppeared = false
    
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
                        isAppeared.toggle()
                        animate(geometry: geometry)
                        onTap()
                    })
                
                content
                    .offset(y: contentOffsetY)
            }
            .onAppear {
                animate(geometry: geometry)
            }
//            .onDisappear {
//                withAnimation(.linear(duration: 0.5)) {
//                    isBackgroundViewHidden = true
//                    contentOffsetY = geometry.size.height
//                }
//            }
        }
        .ignoresSafeArea()
        // デバッグ用なので後で消す
        .id("")
    }
    
    func animate(geometry: GeometryProxy) {
        if !isAppeared {
            contentOffsetY = geometry.size.height
            withAnimation(.linear(duration: 0.5)) {
                isBackgroundViewHidden = false
                contentOffsetY = 0
            }
        }else {
            withAnimation(.linear(duration: 0.5)) {
                isBackgroundViewHidden = true
                contentOffsetY = geometry.size.height
            }
        }
    }
}

struct TestView: View {
    @State var isPresented = false
    @State var transaction = Transaction()
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Color.green
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                transaction.disablesAnimations = true
//                withTransaction(transaction) {
                    isPresented = true
//                }
            }, label: {
                Text("show")
            })
        })
        .sheet(isPresented: $isPresented) {
            CustomTransitionView(
                onTap: {
                    transaction.disablesAnimations = true
//                    withTransaction(transaction) {
                        isPresented = false
//                    }
                },
                content: {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.blue)
                        .frame(width: 400, height: 300)
                }
            )
            .presentationBackground(.clear)
        }
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
