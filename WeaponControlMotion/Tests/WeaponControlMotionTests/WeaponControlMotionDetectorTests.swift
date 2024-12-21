//
//  WeaponControlMotionDetectorTests.swift
//  
//
//  Created by ウルトラ深瀬 on 20/12/24.
//

import XCTest
import CoreMotion
@testable import WeaponControlMotion

final class WeaponControlMotionDetectorTests: XCTestCase {
    private var motionDetector: WeaponControlMotionDetector!
    private var coreMotionManagerStub: CoreMotionManagerStub!

    override func setUpWithError() throws {
        coreMotionManagerStub = .init()
        motionDetector = .init(coreMotionManager: coreMotionManagerStub)
    }

    override func tearDownWithError() throws {
        coreMotionManagerStub = nil
        motionDetector = nil
    }
    
    func test_init() {
        XCTAssertEqual(coreMotionManagerStub.accelerometerUpdateInterval, 0.2)
        XCTAssertEqual(coreMotionManagerStub.gyroUpdateInterval, 0.2)
    }
    
    func test_startDetection() {
        XCTAssertEqual(coreMotionManagerStub.startAccelerometerUpdatesCalledCount, 0)
        XCTAssertEqual(coreMotionManagerStub.startGyroUpdatesCalledCount, 0)
        motionDetector.startDetection()
        XCTAssertEqual(coreMotionManagerStub.startAccelerometerUpdatesCalledCount, 1)
        XCTAssertEqual(coreMotionManagerStub.startGyroUpdatesCalledCount, 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            XCTAssertTrue(self.coreMotionManagerStub.isAccelerometerActive)
            XCTAssertTrue(self.coreMotionManagerStub.isGyroActive)
        })
    }
    
    func test_stopDetection() {
        XCTAssertEqual(coreMotionManagerStub.stopAccelerometerUpdatesCalledCount, 0)
        XCTAssertEqual(coreMotionManagerStub.stopGyroUpdatesCalledCount, 0)
        motionDetector.stopDetection()
        XCTAssertEqual(coreMotionManagerStub.stopAccelerometerUpdatesCalledCount, 1)
        XCTAssertEqual(coreMotionManagerStub.stopGyroUpdatesCalledCount, 1)
        XCTAssertFalse(coreMotionManagerStub.isAccelerometerActive)
        XCTAssertFalse(coreMotionManagerStub.isGyroActive)
    }
    
    func test_fireMotionDetected() {
        var isFireMotionDetectedCalled = false
        
        // 発射モーションが検知された時にフラグをtrueにする
        motionDetector.fireMotionDetected = {
            isFireMotionDetectedCalled = true
        }
        // モーション検知開始
        motionDetector.startDetection()
        
        
        
//        coreMotionManagerStub.gyroHander?(successGyro, nil)
//        coreMotionManagerStub.accelerometerHander?(successAcceleration, nil)
        
//        XCTAssertTrue(isFireMotionDetectedCalled)
        
        // 一度falseにリセット
        isFireMotionDetectedCalled = false
        
    }
}
