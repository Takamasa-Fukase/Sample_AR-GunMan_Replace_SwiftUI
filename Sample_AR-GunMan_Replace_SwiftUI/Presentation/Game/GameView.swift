//
//  GameView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import SwiftUI
import ARShooting
import WeaponControlMotion

struct GameView: View {
    private var arController: ARShootingController
    private var motionDetector: WeaponControlMotionDetector
    @State private var viewModel: GameViewModel
    
    init(
        arController: ARShootingController,
        motionDetector: WeaponControlMotionDetector,
        viewModel: GameViewModel
    ) {
        self.arController = arController
        self.arController.targetHit = {
            viewModel.targetHit()
        }
        self.motionDetector = motionDetector
        self.motionDetector.fireMotionDetected = {
            viewModel.fireMotionDetected()
        }
        self.motionDetector.reloadMotionDetected = {
            viewModel.reloadMotionDetected()
        }
        self.viewModel = viewModel
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack(alignment: .center) {
            // ARコンテンツ部分
            arController.view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            // SwiftUIViewコンテンツ部分
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(Color.goldLeaf.opacity(0.7))
                        .frame(width: 120, height: 50, alignment: .center)
                        .overlay {
                            Text(viewModel.timeCount.timeCountText)
                                .font(.system(size: 35))
                                .foregroundStyle(Color.paper)
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.customDarkBrown.opacity(0.7), lineWidth: 3)
                        }
                    
                    Spacer()
                    
                    Button {
                        // 武器選択画面を表示
                        viewModel.weaponChangeButtonTapped()
                        
                    } label: {
                        Image("weapon_change")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 12))
                
                Spacer()
                
                Image(viewModel.currentWeaponData?.resources.sightImageName ?? "")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(ColorTypeConverter.fromColorType(viewModel.currentWeaponData?.resources.sightImageColorType ?? .red))
                
                Spacer()
                
                HStack(spacing: 0) {
                    Image(viewModel.currentWeaponData?.bulletsCountImageName() ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 210, height: 70, alignment: .bottom)
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.onViewAppear()
        }
        .onDisappear {
            viewModel.onViewDisappear()
        }
        .onReceive(viewModel.arControllerInputEvent) { eventType in
            switch eventType {
            case .runSceneSession:
                arController.runSession()
            case .pauseSceneSession:
                arController.pauseSession()
            case .renderWeaponFiring:
                arController.renderWeaponFiring()
            case .showWeaponObject(let weaponId):
                arController.showWeaponObject(weaponId: weaponId)
            case .changeTargetsAppearance(let imageName):
                arController.changeTargetsAppearance(to: imageName)
            }
        }
        .onReceive(viewModel.motionDetectorInputEvent) { eventType in
            switch eventType {
            case .startDeviceMotionDetection:
                motionDetector.startDetection()
            case .stopDeviceMotionDetection:
                motionDetector.stopDetection()
            }
        }
        .onReceive(viewModel.playSound) { soundType in
            SoundPlayer.shared.play(soundType)
        }
        .showCustomModal(
            isPresented: $viewModel.isTutorialViewPresented,
            applyBlurEffectBackground: true,
            onDismiss: {
                // チュートリアルの完了を通知
                viewModel.tutorialEnded()
            }
        ) { dismissRequestReceiver in
            // チュートリアル画面への遷移
            TutorialView(
                // 内部からのdismissリクエストをレシーバーに送信できる様に受け渡し
                dismissRequestReceiver: dismissRequestReceiver
            )
            // sheetの背景を透過
            .presentationBackground(.clear)
        }
        .sheet(isPresented: $viewModel.isWeaponSelectViewPresented) {
            // 武器選択画面に遷移
            WeaponSelectViewFactory.create(weaponSelected: { weaponId in
                viewModel.weaponSelected(weaponId: weaponId)
            })
            // sheetの背景を透過
            .presentationBackground(.clear)
            .ignoresSafeArea()
        }
        .sheet(isPresented: $viewModel.isResultViewPresented) {
            // 結果画面に遷移
            
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
    GameViewFactory.create(frame: .zero)
}
