//
//  GameView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import SwiftUI

struct GameView<ViewModel: GameViewModelInterface>: View {
    private var arController: GameARControllerInterface
    @StateObject private var viewModel: ViewModel
    
    init(
        arController: GameARControllerInterface,
        viewModel: ViewModel
    ) {
        self.arController = arController
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            // ARコンテンツ部分
            GameARViewContainer(arController: arController)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // SwiftUIViewコンテンツ部分
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(viewModel.timeCount.timeCountText)
                        .font(.system(size: 32))
                        .frame(width: 120, height: 60, alignment: .center)
                        .foregroundStyle(Color(.systemBackground))
                        .background(Color(.label))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Spacer()
                    
                    Button {
                        //TODO: 武器選択画面を表示
                        
                    } label: {
                        Image("weapon_change")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                }
                
                Image("pistol_sight")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.red)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Image(viewModel.currentWeaponData?.bulletsCountImageName() ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 80, alignment: .bottom)
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        button(title: "Fire") {
                            viewModel.fireButtonTapped()
                        }
                        button(title: "Reload") {
                            viewModel.reloadButtonTapped()
                        }
                    }
                }
            }
        }
        // TODO: 後で直したい
        // landscapeだと左右のSafeAreaが考慮されずに謎の伸びが発生してレイアウトがおかしくなっているのでpaddingを+1して暫定対応している
        .padding([.leading, .trailing], 1)
        .onAppear {
            viewModel.onViewAppear()
        }
        .onDisappear {
            viewModel.onViewDisappear()
        }
        .onReceive(viewModel.weaponFiringRenderRequest) { _ in
            arController.renderWeaponFiring()
        }
        .onReceive(viewModel.weaponObjectShowRequest) { weaponObjectData in
            arController.showWeaponObject(objectData: weaponObjectData)
        }
        .onReceive(viewModel.sceneSessionRunRequest) { _ in
            arController.runSession()
        }
        .onReceive(viewModel.sceneSessionPauseRequest) { _ in
            arController.pauseSession()
        }
    }
    
    private func button(
        title: String,
        onTap: @escaping (() -> Void)
    ) -> some View {
        Button {
            onTap()
        } label: {
            Text(title)
                .foregroundStyle(Color(.label))
                .frame(width: 80, height: 40)
                .background(.tint)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    PresentationFactory.createGameView(frame: .zero)
}
