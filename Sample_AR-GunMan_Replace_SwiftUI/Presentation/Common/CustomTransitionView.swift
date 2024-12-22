//
//  CustomTransitionView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 22/12/24.
//

import SwiftUI

struct CustomModalPresenter<Content: View>: View {
    @Binding var isPresented: Bool
    let dismissOnBackgroundTap: Bool
    let onDismiss: (() -> Void)?
    let content: Content
    
    init(
        isPresented: Binding<Bool>,
        dismissOnBackgroundTap: Bool = true,
        onDismiss: (() -> Void)?,
        @ViewBuilder content: (() -> Content)
    ) {
        self._isPresented = Binding<Bool>(projectedValue: isPresented)
        self.dismissOnBackgroundTap = dismissOnBackgroundTap
        self.onDismiss = onDismiss
        self.content = content()
    }
    
    var body: some View {
        if isPresented {
            content.modifier(
                CustomModalModifier(
                    dismissOnBackgroundTap: true,
                    onDismiss: {
                        onDismiss?()
                        isPresented = false
                    })
            )
        }
    }
}

struct CustomModalModifier: ViewModifier {
    var dismissOnBackgroundTap = false
    var onDismiss: (() -> Void)?
    @State private var backgroundOpacity: CGFloat = 0.0
    @State private var contentOffsetY: CGFloat = 0.0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.black
                    .opacity(backgroundOpacity)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture(perform: {
                        if dismissOnBackgroundTap {
                            animate(isAppearing: false, geometry) {
                                onDismiss?()
                            }
                        }
                    })
                
                content
                    .offset(y: contentOffsetY)
            }
            .onAppear {
                animate(isAppearing: true, geometry)
            }
            .onDisappear {
                onDismiss?()
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
                backgroundOpacity = 0.7
                contentOffsetY = 0
            }
        }
        // 表示終了時の処理
        else {
            withAnimation(.linear(duration: duration)) {
                backgroundOpacity = 0.0
                contentOffsetY = geometry.size.height
            } completion: {
                completion?()
            }
        }
    }
}

extension View {
    func showCustomModal<Content: View>(
        isPresented: Binding<Bool>,
        dismissOnBackgroundTap: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: (() -> Content)
    ) -> some View {
        return CustomModalPresenter<Content>(
            isPresented: isPresented,
            dismissOnBackgroundTap: dismissOnBackgroundTap,
            onDismiss: onDismiss,
            content: content
        )
    }
}

struct CustomModalTestView: View {
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
        })
        .ignoresSafeArea()
        .showCustomModal(
            isPresented: $isPresented,
            onDismiss: {
                
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.orange)
                    .frame(width: 400, height: 300)
                    .presentationBackground(.clear)
            }
    }
}

#Preview {
    CustomModalTestView()
}
