//
//  NameRegisterView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 9/1/25.
//

import SwiftUI

struct NameRegisterView: View {
    @State var viewModel = NameRegisterViewModel()
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack(spacing: 0) {
            Group {
                Spacer()
                    .frame(height: 14)
                
                Text("Congratulations!")
                    .font(.custom("Copperplate Bold", size: 25))
                    .foregroundStyle(Color.paper)
                    .frame(height: 25)
                
                HStack(spacing: 0) {
                    Text("You're ranked at ")
                        .font(.custom("Copperplate", size: 21))
                        .foregroundStyle(Color.paper)
                    
                    // ランク表示
                    Text(viewModel.rankText)
                        .font(.custom("Copperplate", size: 25))
                        .foregroundStyle(Color.customDarkBrown)
                        .frame(minWidth: 58)
                    
                    Text(" in")
                        .font(.custom("Copperplate", size: 21))
                        .foregroundStyle(Color.paper)
                }
                .frame(height: 25.5)
                
                Text("the world!")
                    .font(.custom("Copperplate", size: 21))
                    .foregroundStyle(Color.paper)
                    .frame(height: 21.5)
                
                // スコア表示
                Text("Score: 78.753")
                    .font(.custom("Copperplate Bold", size: 38))
                    .foregroundStyle(Color.paper)
                    .frame(height: 36)

                HStack(spacing: 0) {
                    Spacer()
                        .frame(width: 24)
                    
                    Text("Name:")
                        .font(.custom("Copperplate", size: 20))
                        .foregroundStyle(Color.paper)
                    
                    Spacer()
                        .frame(width: 4)
                    
                    // 名前入力フォーム
                    TextField("", text: $viewModel.nameText)
                        .font(.custom("Copperplate", size: 30))
                        .foregroundStyle(Color.goldLeaf)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.customDarkBrown)
                                .frame(height: 40)
                        )
                        .frame(height: 40)
                    
                    Spacer()
                        .frame(width: 24)
                }
                
                Spacer()
                    .frame(height: 16)
            }
            .foregroundStyle(Color.paper)
            
            Color.black
                .frame(height: 1)
            
            HStack(spacing: 0) {
                Button {
                    viewModel.noButtonTapped()
                } label: {
                    Text("No, thanks")
                        .font(.custom("Copperplate Bold", size: 22))
                        .foregroundStyle(Color(.darkGray))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Color.black
                    .frame(width: 1)
                
                Button {
                    viewModel.registerButtonTapped()
                } label: {
                    Text("Register!")
                        .font(.custom("Copperplate Bold", size: 28))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(height: 46)
        }
        .frame(width: 412)
        .background(Color.goldLeaf)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.paper, lineWidth: 1)
                .padding(0.5)
        }
        .padding(.all, 5.2)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.paper, lineWidth: 2)
        }
    }
}

#Preview {
    CenterPreviewView(backgroundColor: .black) {
        NameRegisterView()
    }
}
