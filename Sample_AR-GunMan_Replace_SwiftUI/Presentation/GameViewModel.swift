//
//  GameViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import Foundation
import Combine

final class GameViewModel: ObservableObject {
    @Published var timeCount: Double = 30.00
    @Published var currentWeaponData: CurrentWeaponData?
    
    // TODO: 値を外側から流せないように外部に公開するプロパティはPublisherなどにする（Observableみたいに）
    let weaponFireRenderingRequest = PassthroughSubject<Void, Never>()
    let weaponShowingRequest = PassthroughSubject<WeaponObjectData, Never>()
    
    private let weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface
    private let weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    
    init(
        weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface,
        weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    ) {
        self.weaponResourceGetUseCase = weaponResourceGetUseCase
        self.weaponActionExecuteUseCase = weaponActionExecuteUseCase
        
        do {
            currentWeaponData = try self.weaponResourceGetUseCase.getDefaultWeaponDetail()
            
        } catch {
            print("defaultWeaponGetUseCase error: \(error)")
        }
    }
    
    func onViewAppear() {
        guard let currentWeaponData = currentWeaponData else { return }
        weaponShowingRequest.send(currentWeaponData.extractWeaponObjectData())
    }
    
    func fireWeapon() {
        weaponActionExecuteUseCase.fireWeapon(
            bulletsCount: currentWeaponData?.state.bulletsCount ?? 0,
            isReloading: currentWeaponData?.state.isReloading ?? false,
            reloadType: currentWeaponData?.spec.reloadType ?? .manual,
            onFired: { response in
                currentWeaponData?.state.bulletsCount = response.bulletsCount
//                view?.renderWeaponFiring()
                weaponFireRenderingRequest.send(Void())
                
//                view?.playSound(type: currentWeaponData?.resources.firingSound ?? .pistolShoot)
//                view?.showBulletsCountImage(name: currentWeaponData?.bulletsCountImageName() ?? "")
                
                if response.needsAutoReload {
                    // リロードを自動的に実行
                    reloadWeapon()
                }
            },
            onCanceled: {
                if let noBulletsSound = currentWeaponData?.resources.noBulletsSound {
//                    view?.playSound(type: noBulletsSound)
                }
            })
    }
    
    func reloadWeapon() {
        weaponActionExecuteUseCase.reloadWeapon(
            bulletsCount: currentWeaponData?.state.bulletsCount ?? 0,
            isReloading: currentWeaponData?.state.isReloading ?? false,
            capacity: currentWeaponData?.spec.capacity ?? 0,
            reloadWaitingTime: currentWeaponData?.spec.reloadWaitingTime ?? 0,
            onReloadStarted: { response in
                currentWeaponData?.state.isReloading = response.isReloading
//                view?.playSound(type: currentWeaponData?.resources.reloadingSound ?? .pistolReload)
            },
            onReloadEnded: { [weak self] response in
                self?.currentWeaponData?.state.bulletsCount = response.bulletsCount
                self?.currentWeaponData?.state.isReloading = response.isReloading
//                self?.view?.showBulletsCountImage(name: self?.currentWeaponData?.bulletsCountImageName() ?? "")
            })
    }
}
