//
//  CameraUsagePermissionHandlingUseCase.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 21/12/24.
//

import Foundation

protocol CameraUsagePermissionHandlingUseCaseInterface {
    func checkGrantedFlag() -> Bool
    func requestPermission()
}

final class CameraUsagePermissionHandlingUseCase: CameraUsagePermissionHandlingUseCaseInterface {
    private let permissionRepository: PermissionRepositoryInterface
    
    init(permissionRepository: PermissionRepositoryInterface) {
        self.permissionRepository = permissionRepository
    }
    
    func checkGrantedFlag() -> Bool {
        return permissionRepository.getCameraUsagePermissionGrantedFlag()
    }
    
    func requestPermission() {
        permissionRepository.requestCameraUsagePermission()
    }
}
