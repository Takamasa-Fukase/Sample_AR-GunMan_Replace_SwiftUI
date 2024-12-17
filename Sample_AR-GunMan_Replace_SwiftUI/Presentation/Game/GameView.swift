//
//  GameView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import SwiftUI
import ARShootingApp

struct GameView: View {
    private var arShootingController: ARShootingController
    private var deviceMotionController: DeviceMotionController
    @Bindable private var viewModel: GameViewModel
    
    init(
        arShootingController: ARShootingController,
        deviceMotionController: DeviceMotionController,
        viewModel: GameViewModel
    ) {
        self.arShootingController = arShootingController
        self.arShootingController.targetHit = {
            viewModel.targetHit()
        }
        self.deviceMotionController = deviceMotionController
        self.deviceMotionController.accelerationUpdated = { acceleration, latestGyro in
            viewModel.accelerationUpdated(acceleration: acceleration, latestGyro: latestGyro)
        }
        self.deviceMotionController.gyroUpdated = { gyro in
            viewModel.gyroUpdated(gyro)
        }
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            // ARコンテンツ部分
            ARShootingView(sceneView: arShootingController.getSceneView())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
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
                        // 武器選択画面を表示
                        viewModel.weaponChangeButtonTapped()
                        
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
                arShootingController.runSession()
            case .pauseSceneSession:
                arShootingController.pauseSession()
            case .startDeviceMotionDetection:
                deviceMotionController.startMotionDetection()
            case .stopDeviceMotionDetection:
                deviceMotionController.stopMotionDetection()
            case .renderWeaponFiring:
                arShootingController.renderWeaponFiring()
            case .showWeaponObject(let weaponObjectData):
                let objectData = DataModelMapper.convertDomainWeaponObjectDataForARShootingApp(weaponObjectData)
                arShootingController.showWeaponObject(objectData: objectData)
            case .changeTargetsAppearance(let imageName):
                arShootingController.changeTargetsAppearance(to: imageName)
            }
        }
        .onReceive(viewModel.playSound) { soundType in
            SoundPlayer.shared.play(soundType)
        }
        .sheet(isPresented: $viewModel.isWeaponSelectViewPresented) {
            // 武器選択画面に遷移
            WeaponSelectView(weaponSelected: { weaponId in
                viewModel.weaponSelected(weaponId: weaponId)
            })
            // sheetの背景を透過
            .presentationBackground(.clear)
            .ignoresSafeArea()
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
