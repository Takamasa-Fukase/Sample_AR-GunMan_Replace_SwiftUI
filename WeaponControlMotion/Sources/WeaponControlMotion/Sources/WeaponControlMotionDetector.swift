//
//  WeaponControlMotionDetector.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 16/11/24.
//

import Foundation
import CoreMotion

public final class WeaponControlMotionDetector {
    public var fireMotionDetected: (() -> Void)?
    public var reloadMotionDetected: (() -> Void)?
    private let coreMotionManager = CMMotionManager()
    
    public init() {
        coreMotionManager.accelerometerUpdateInterval = 0.2
        coreMotionManager.gyroUpdateInterval = 0.2
    }

    public func startDetection() {
        guard !coreMotionManager.isAccelerometerActive && !coreMotionManager.isGyroActive else { return }
        guard let currentOperationQueue = OperationQueue.current else { return }
        
        coreMotionManager.startAccelerometerUpdates(to: currentOperationQueue) { [weak self] data, error in
            if let error = error {
                print(error)
                return
            }
            guard let acceleration = data?.acceleration else { return }
            guard let latestGyro = self?.coreMotionManager.gyroData?.rotationRate else { return }
            DeviceMotionFilter.accelerationUpdated(
                acceleration: acceleration,
                latestGyro: latestGyro,
                onDetectFireMotion: {
                    self?.fireMotionDetected?()
                })
        }
        
        coreMotionManager.startGyroUpdates(to: currentOperationQueue) { [weak self] data, error in
            if let error = error {
                print(error)
                return
            }
            guard let gyro = data?.rotationRate else { return }
            DeviceMotionFilter.gyroUpdated(
                gyro: gyro,
                onDetectReloadMotion: {
                    self?.reloadMotionDetected?()
                })
        }
    }
    
    public func stopDetection() {
        coreMotionManager.stopAccelerometerUpdates()
        coreMotionManager.stopGyroUpdates()
    }
}
