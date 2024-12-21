//
//  DeviceMotionFilter.swift
//
//
//  Created by ウルトラ深瀬 on 18/12/24.
//

import Foundation
import CoreMotion

final class DeviceMotionFilter {
    static func accelerationUpdated(
        acceleration: CMAcceleration,
        latestGyro: CMRotationRate,
        onDetectFireMotion: (() -> Void)
    ) {
        let accelerationCompositeValue = CompositeCalculator.getCompositeValue(
            x: 0,
            y: acceleration.y,
            z: acceleration.z
        )
        let gyroCompositeValue = CompositeCalculator.getCompositeValue(
            x: 0,
            y: 0,
            z: latestGyro.z
        )
        print("DeviceMotionFilter.accelerationUpdated()\n - acceleration: \(acceleration)\n - latestGyro: \(latestGyro)\n - accelerationCompositeValue: \(accelerationCompositeValue), gyroCompositeValue: \(gyroCompositeValue)")
        if accelerationCompositeValue >= 1.5 && gyroCompositeValue < 10 {
            onDetectFireMotion()
        }
    }
    
    static func gyroUpdated(
        gyro: CMRotationRate,
        onDetectReloadMotion: (() -> Void)
    ) {
        let gyroCompositeValue = CompositeCalculator.getCompositeValue(
            x: 0,
            y: 0,
            z: gyro.z
        )
        print("DeviceMotionFilter.gyroUpdated()\n - gyro: \(gyro)\n - gyroCompositeValue: \(gyroCompositeValue)")
        if gyroCompositeValue >= 10 {
            onDetectReloadMotion()
        }
    }
}
