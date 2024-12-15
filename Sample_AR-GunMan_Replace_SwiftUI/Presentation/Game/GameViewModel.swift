//
//  GameViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import Foundation
import Combine

final class GameViewModel: ObservableObject {
    enum ARControllerInputEventType {
        case runSceneSession
        case pauseSceneSession
        case renderWeaponFiring
        case showWeaponObject(_ weaponObjectData: WeaponObjectData)
    }
    
    // MARK: ViewへのOutput（表示するデータ）
    @Published var timeCount: Double = 30.00
    @Published var currentWeaponData: CurrentWeaponData?
    
    // MARK: ViewへのOutput（イベント通知）
    let arControllerInputEvent = PassthroughSubject<ARControllerInputEventType, Never>()
    let playSound = PassthroughSubject<SoundType, Never>()
        
    private let weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface
    private let weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    private var score: Double = 0.0
    
    init(
        weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface,
        weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    ) {
        self.weaponResourceGetUseCase = weaponResourceGetUseCase
        self.weaponActionExecuteUseCase = weaponActionExecuteUseCase
        
        getDefaultWeaponDetail()
    }
    
    // MARK: ViewからのInput
    func onViewAppear() {
        arControllerInputEvent.send(.runSceneSession)
        guard let currentWeaponData = currentWeaponData else { return }
        arControllerInputEvent.send(.showWeaponObject(currentWeaponData.extractWeaponObjectData()))
    }
    
    func onViewDisappear() {
        arControllerInputEvent.send(.pauseSceneSession)
    }
    
    func fireButtonTapped() {
        fireWeapon()
    }
    
    func reloadButtonTapped() {
        reloadWeapon()
    }
    
    func weaponChangeButtonTapped() {
        
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
    private func getDefaultWeaponDetail() {
        do {
            currentWeaponData = try self.weaponResourceGetUseCase.getDefaultWeaponDetail()
            
        } catch {
            print("defaultWeaponGetUseCase error: \(error)")
        }
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
