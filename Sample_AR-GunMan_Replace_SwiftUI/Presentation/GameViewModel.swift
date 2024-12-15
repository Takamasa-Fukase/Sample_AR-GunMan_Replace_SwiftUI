//
//  GameViewModel.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import Foundation
import Combine

protocol GameViewModelInterface: ObservableObject {
    // MARK: ViewへのOutput（表示するデータ）
    var timeCount: Double { get set }
    var currentWeaponData: CurrentWeaponData? { get set }
    
    // MARK: ViewへのOutput（イベント通知）
    var sceneSessionRunRequest: PassthroughSubject<Void, Never> { get }
    var sceneSessionPauseRequest: PassthroughSubject<Void, Never> { get }
    var weaponFiringRenderRequest: PassthroughSubject<Void, Never> { get }
    var weaponObjectShowRequest: PassthroughSubject<WeaponObjectData, Never> { get }
    
    // MARK: ViewからのInput
    func onViewAppear()
    func onViewDisappear()
    func fireButtonTapped()
    func reloadButtonTapped()
    func weaponChangeButtonTapped()
}

final class GameViewModel: GameViewModelInterface {
    @Published var timeCount: Double = 30.00
    @Published var currentWeaponData: CurrentWeaponData?
    
    let sceneSessionRunRequest = PassthroughSubject<Void, Never>()
    let sceneSessionPauseRequest = PassthroughSubject<Void, Never>()
    let weaponFiringRenderRequest = PassthroughSubject<Void, Never>()
    let weaponObjectShowRequest = PassthroughSubject<WeaponObjectData, Never>()
    
    private let weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface
    private let weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    
    init(
        weaponResourceGetUseCase: WeaponResourceGetUseCaseInterface,
        weaponActionExecuteUseCase: WeaponActionExecuteUseCaseInterface
    ) {
        self.weaponResourceGetUseCase = weaponResourceGetUseCase
        self.weaponActionExecuteUseCase = weaponActionExecuteUseCase
        
        getDefaultWeaponDetail()
    }
    
    func onViewAppear() {
        sceneSessionRunRequest.send(Void())
        guard let currentWeaponData = currentWeaponData else { return }
        weaponObjectShowRequest.send(currentWeaponData.extractWeaponObjectData())
    }
    
    func onViewDisappear() {
        sceneSessionPauseRequest.send(Void())
    }
    
    func fireButtonTapped() {
        fireWeapon()
    }
    
    func reloadButtonTapped() {
        reloadWeapon()
    }
    
    func weaponChangeButtonTapped() {
        
    }
    
    // MARK: Private Methods
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
//                view?.renderWeaponFiring()
                weaponFiringRenderRequest.send(Void())
                
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
    
    private func reloadWeapon() {
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
