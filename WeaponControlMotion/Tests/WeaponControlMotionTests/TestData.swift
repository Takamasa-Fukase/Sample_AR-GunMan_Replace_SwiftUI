//
//  TestData.swift
//
//
//  Created by ウルトラ深瀬 on 21/12/24.
//

import Foundation
@testable import WeaponControlMotion

// MARK: 発射モーション判定の加速度条件の境界値データ
// 条件: 合成値 >= 1.5
//  - 合成値が 1.501264 になるので満たしている
let validFireMotionAcceleration = DummyCMAccelerometerData(x: 0, y: 1.0, z: 0.708)
//  - 合成値が 1.499849 になるので満たしていない
let invalidFireMotionAcceleration = DummyCMAccelerometerData(x: 0, y: 1.0, z: 0.707)


// MARK: 発射モーション判定のジャイロ条件の境界値データ
// 条件: 合成値 < 10
//  - 合成値が 9.998244 になるので満たしている
let validFireMotionGyro = DummyCMGyroData(x: 0, y: 0, z: 3.162)
//  - 合成値が 10.004568 になるので満たしていない
let invalidFireMotionGyro = DummyCMGyroData(x: 0, y: 0, z: 3.163)


// MARK: リロードモーション判定のジャイロ条件の境界値データ
// 条件: 合成値 >= 10
//  - 合成値が 10.004568 になるので満たしている
let validReloadMotionGyro = DummyCMGyroData(x: 0, y: 0, z: 3.163)
//  - 合成値が 9.998244 になるので満たしていない
let invalidReloadMotionGyro = DummyCMGyroData(x: 0, y: 0, z: 3.162)


// MARK: テストケース作成・更新時に使用する
func checkTestDataCompositeValues() {
    print("\n\n=== checkTestDataCompositeValues開始 ===\n")
    
    let compositeOfValidFireMotionAcceleration = CompositeCalculator.getCompositeValue(
        x: validFireMotionAcceleration.acceleration.x,
        y: validFireMotionAcceleration.acceleration.y,
        z: validFireMotionAcceleration.acceleration.z
    )
    print("compositeOfValidFireMotionAcceleration: \(compositeOfValidFireMotionAcceleration)")
    
    let compositeOfInvalidFireMotionAcceleration = CompositeCalculator.getCompositeValue(
        x: invalidFireMotionAcceleration.acceleration.x,
        y: invalidFireMotionAcceleration.acceleration.y,
        z: invalidFireMotionAcceleration.acceleration.z
    )
    print("compositeOfInvalidFireMotionAcceleration: \(compositeOfInvalidFireMotionAcceleration)")
    
    let compositeOfValidFireMotionGyro = CompositeCalculator.getCompositeValue(
        x: validFireMotionGyro.rotationRate.x,
        y: validFireMotionGyro.rotationRate.y,
        z: validFireMotionGyro.rotationRate.z
    )
    print("compositeOfValidFireMotionGyro: \(compositeOfValidFireMotionGyro)")
    
    let compositeOfInvalidFireMotionGyro = CompositeCalculator.getCompositeValue(
        x: invalidFireMotionGyro.rotationRate.x,
        y: invalidFireMotionGyro.rotationRate.y,
        z: invalidFireMotionGyro.rotationRate.z
    )
    print("compositeOfInvalidFireMotionGyro: \(compositeOfInvalidFireMotionGyro)")
    
    let compositeOfValidReloadMotionGyro = CompositeCalculator.getCompositeValue(
        x: validReloadMotionGyro.rotationRate.x,
        y: validReloadMotionGyro.rotationRate.y,
        z: validReloadMotionGyro.rotationRate.z
    )
    print("compositeOfValidReloadMotionGyro: \(compositeOfValidReloadMotionGyro)")
    
    let compositeOfInvalidReloadMotionGyro = CompositeCalculator.getCompositeValue(
        x: invalidReloadMotionGyro.rotationRate.x,
        y: invalidReloadMotionGyro.rotationRate.y,
        z: invalidReloadMotionGyro.rotationRate.z
    )
    print("compositeOfInvalidReloadMotionGyro: \(compositeOfInvalidReloadMotionGyro)")
    
    print("\n=== checkTestDataCompositeValues終了 ===\n\n")
}
