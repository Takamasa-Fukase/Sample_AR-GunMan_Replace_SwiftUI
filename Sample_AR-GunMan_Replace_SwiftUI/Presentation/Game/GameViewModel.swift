//
//  GameViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import Foundation
import Observation
import Combine

@Observable
final class GameViewModel {
    enum ARControllerInputEventType {
        case runSceneSession
        case pauseSceneSession
        case startDeviceMotionDetection
        case stopDeviceMotionDetection
        case renderWeaponFiring
        case showWeaponObject(_ weaponObjectData: WeaponObjectData)
        case changeTargetsAppearance(imageName: String)
    }
    
    // MARK: ViewへのOutput（表示するデータ）
    private(set) var timeCount: Double = 30.00
    private(set) var currentWeaponData: CurrentWeaponData?
    var isWeaponSelectViewPresented = false
    
    // MARK: ViewへのOutput（イベント通知）
    let arControllerInputEvent = PassthroughSubject<ARControllerInputEventType, Never>()
    let playSound = PassthroughSubject<SoundType, Never>()
        
    private let weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface
    private let weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    private var score: Double = 0.0
    private var reloadingMotionDetecedCount: Int = 0
    
    init(
        weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface,
        weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    ) {
        self.weaponResourceGetUseCase = weaponResourceGetUseCase
        self.weaponActionExecuteUseCase = weaponActionExecuteUseCase
    }
    
    // MARK: ViewからのInput
    func onViewAppear() {
        do {
            let selectedWeaponData = try weaponResourceGetUseCase.getDefaultWeaponDetail()
            showSelectedWeapon(selectedWeaponData)
            
        } catch {
            print("defaultWeaponGetUseCase error: \(error)")
        }
        
        arControllerInputEvent.send(.runSceneSession)
        arControllerInputEvent.send(.startDeviceMotionDetection)
    }
    
    func onViewDisappear() {
        arControllerInputEvent.send(.pauseSceneSession)
        arControllerInputEvent.send(.stopDeviceMotionDetection)
    }

//    func accelerationUpdated(acceleration: Vector, latestGyro: Vector) {
//        let accelerationCompositeValue = CompositeCalculator.getCompositeValue(
//            x: 0,
//            y: acceleration.y,
//            z: acceleration.z
//        )
//        let gyroCompositeValue = CompositeCalculator.getCompositeValue(
//            x: 0,
//            y: 0,
//            z: latestGyro.z
//        )
//        if accelerationCompositeValue >= 1.5 && gyroCompositeValue < 10 {
//            fireWeapon()
//        }
//    }
//    
//    func gyroUpdated(_ gyro: Vector) {
//        let gyroCompositeValue = CompositeCalculator.getCompositeValue(
//            x: 0,
//            y: 0,
//            z: gyro.z
//        )
//        if gyroCompositeValue >= 10 {
//            reloadWeapon()
//            reloadingMotionDetecedCount += 1
//            if reloadingMotionDetecedCount == 20 {
//                playSound.send(.kyuiin)
//                arControllerInputEvent.send(.changeTargetsAppearance(imageName: "taimeisan.jpg"))
//            }
//        }
//    }
    
    func weaponChangeButtonTapped() {
        isWeaponSelectViewPresented = true
    }
    
    func weaponSelected(weaponId: Int) {
        do {
            let selectedWeaponData = try weaponResourceGetUseCase.getWeaponDetail(of: weaponId)
            showSelectedWeapon(selectedWeaponData)
            
        } catch {
            print("WeaponDetailGetRequest error: \(error)")
        }
    }
    
    func targetHit() {
        //ランキングがバラけるように、加算する得点自体に90%~100%の間の乱数を掛ける
        let randomlyAdjustedHitPoint = Double(currentWeaponData?.spec.targetHitPoint ?? 0) * Double.random(in: 0.9...1)
        // 100を超えない様に更新する
        score = min(score + randomlyAdjustedHitPoint, 100.0)
        
        playSound.send(.headShot)
        
        if let targetHitSound = currentWeaponData?.resources.targetHitSound {
            playSound.send(targetHitSound)
        }
    }
    
    // MARK: Privateメソッド
    private func showSelectedWeapon(_ selectedWeaponData: CurrentWeaponData) {
        self.currentWeaponData = selectedWeaponData
        
        guard let currentWeaponData = self.currentWeaponData else { return }
        arControllerInputEvent.send(.showWeaponObject(currentWeaponData.extractWeaponObjectData()))
        
//        if isCheckedTutorialCompletedFlag {
        playSound.send(currentWeaponData.resources.showingSound)
//        }
    }
    
    private func fireWeapon() {
        weaponActionExecuteUseCase.fireWeapon(
            bulletsCount: currentWeaponData?.state.bulletsCount ?? 0,
            isReloading: currentWeaponData?.state.isReloading ?? false,
            reloadType: currentWeaponData?.spec.reloadType ?? .manual,
            onFired: { response in
                currentWeaponData?.state.bulletsCount = response.bulletsCount
                arControllerInputEvent.send(.renderWeaponFiring)
                playSound.send(currentWeaponData?.resources.firingSound ?? .pistolShoot)
                
                if response.needsAutoReload {
                    // リロードを自動的に実行
                    reloadWeapon()
                }
            },
            onCanceled: {
                if let noBulletsSound = currentWeaponData?.resources.noBulletsSound {
                    playSound.send(noBulletsSound)
                }
            })
    }
    
    private func reloadWeapon() {
        weaponActionExecuteUseCase.reloadWeapon(
            bulletsCount: currentWeaponData?.state.bulletsCount ?? 0,
            isReloading: currentWeaponData?.state.isReloading ?? false,
            capacity: currentWeaponData?.spec.capacity ?? 0,
            reloadWaitingTime: currentWeaponData?.spec.reloadWaitingTime ?? 0,
            onReloadStarted: { response in
                currentWeaponData?.state.isReloading = response.isReloading
                playSound.send(currentWeaponData?.resources.reloadingSound ?? .pistolReload)
            },
            onReloadEnded: { [weak self] response in
                self?.currentWeaponData?.state.bulletsCount = response.bulletsCount
                self?.currentWeaponData?.state.isReloading = response.isReloading
            })
    }
}
