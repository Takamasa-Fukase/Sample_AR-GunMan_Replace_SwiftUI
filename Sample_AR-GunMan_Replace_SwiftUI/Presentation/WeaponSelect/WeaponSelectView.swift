//
//  WeaponSelectView.swift
//  AR-GunMan
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI

struct WeaponSelectView: View {
    @State var viewModel: WeaponSelectViewModel
    let weaponSelected: (Int) -> Void
    
    var body: some View {
        ContentFrameTrackableScrollView(
            scrollDirections: .horizontal,
            showsIndicator: false,
            content: {
                HStack(spacing: 100) {
                    ForEach(Array(viewModel.weaponListItems.enumerated()), id: \.offset) { index, item in
                        Image(item.weaponImageName)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.white)
                            .id(index)
                    }
                }
            },
            onScroll: { contentFrame in
                
            }
        )
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

#Preview {
    CenterPreviewView(backgroundColor: .black) {
        WeaponSelectViewFactory.create(weaponSelected: {_ in })
    }
}
