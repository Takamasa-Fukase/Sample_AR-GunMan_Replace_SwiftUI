//
//  DeviceMotionController.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 16/11/24.
//

import Foundation
import CoreMotion

protocol DeviceMotionControllerInterface {
    var accelerationUpdated: ((_ acceleration: Vector, _ latestGyro: Vector) -> Void)? { get set }
    var gyroUpdated: ((Vector) -> Void)? { get set }
    func startMotionDetection()
    func stopMotionDetection()
}

final class DeviceMotionController {
    private let coreMotionManager = CMMotionManager()
    var accelerationUpdated: ((_ acceleration: Vector, _ latestGyro: Vector) -> Void)?
    var gyroUpdated: ((Vector) -> Void)?
    
    init() {
        coreMotionManager.accelerometerUpdateInterval = 0.2
        coreMotionManager.gyroUpdateInterval = 0.2
    }
}

extension DeviceMotionController: DeviceMotionControllerInterface {
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
            self?.accelerationUpdated?(accelerationVector, latestGyroVector)
        }
        
        coreMotionManager.startGyroUpdates(to: currentOperationQueue) { [weak self] data, error in
            if let error = error {
                print(error)
                return
            }
            guard let rotationRate = data?.rotationRate else { return }
            let vector = Vector(x: rotationRate.x, y: rotationRate.y, z: rotationRate.z)
            self?.gyroUpdated?(vector)
        }
    }
    
    func stopMotionDetection() {
        coreMotionManager.stopAccelerometerUpdates()
        coreMotionManager.stopGyroUpdates()
    }
}
