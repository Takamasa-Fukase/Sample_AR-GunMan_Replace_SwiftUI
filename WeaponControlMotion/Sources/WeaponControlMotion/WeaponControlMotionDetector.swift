//
//  WeaponControlMotionDetector.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 16/11/24.
//

import Foundation
import CoreMotion

final class WeaponControlMotionDetector {
    var fireMotionDetected: (() -> Void)?
    var reloadMotionDetected: (() -> Void)?
    private let coreMotionManager = CMMotionManager()
    
    init() {
        coreMotionManager.accelerometerUpdateInterval = 0.2
        coreMotionManager.gyroUpdateInterval = 0.2
    }

    func startMotionDetection() {
        guard !coreMotionManager.isAccelerometerActive && !coreMotionManager.isGyroActive else { return }
        guard let currentOperationQueue = OperationQueue.current else { return }
        
        coreMotionManager.startAccelerometerUpdates(to: currentOperationQueue) { [weak self] data, error in
            if let error = error {
                print(error)
                return
            }
            guard let acceleration = data?.acceleration else { return }
            let accelerationVector = Vector(x: acceleration.x, y: acceleration.y, z: acceleration.z)
            let latestGyro = self?.coreMotionManager.gyroData?.rotationRate ?? CMRotationRate(x: 0, y: 0, z: 0)
            let latestGyroVector = Vector(x: latestGyro.x, y: latestGyro.y, z: latestGyro.z)
            DeviceMotionFilter.accelerationUpdated(
                acceleration: accelerationVector,
                latestGyro: latestGyroVector,
                onDetectFireMotion: {
                    self?.fireMotionDetected?()
                })
        }
        
        coreMotionManager.startGyroUpdates(to: currentOperationQueue) { [weak self] data, error in
            if let error = error {
                print(error)
                return
            }
            guard let rotationRate = data?.rotationRate else { return }
            let vector = Vector(x: rotationRate.x, y: rotationRate.y, z: rotationRate.z)
            DeviceMotionFilter.gyroUpdated(
                gyro: vector,
                onDetectReloadMotion: {
                    self?.reloadMotionDetected?()
                })
        }
    }
    
    func stopMotionDetection() {
        coreMotionManager.stopAccelerometerUpdates()
        coreMotionManager.stopGyroUpdates()
    }
}
