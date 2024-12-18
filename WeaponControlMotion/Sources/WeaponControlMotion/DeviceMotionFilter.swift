//
//  DeviceMotionFilter.swift
//
//
//  Created by ウルトラ深瀬 on 18/12/24.
//

import Foundation

final class DeviceMotionFilter {
    static func accelerationUpdated(
        acceleration: Vector,
        latestGyro: Vector,
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
        if accelerationCompositeValue >= 1.5 && gyroCompositeValue < 10 {
            onDetectFireMotion()
        }
    }
    
    static func gyroUpdated(
        gyro: Vector,
        onDetectReloadMotion: (() -> Void)
    ) {
        let gyroCompositeValue = CompositeCalculator.getCompositeValue(
            x: 0,
            y: 0,
            z: gyro.z
        )
        if gyroCompositeValue >= 10 {
            onDetectReloadMotion()
        }
    }
}
