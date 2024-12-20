//
//  CoreMotionManagerStub.swift
//
//
//  Created by ウルトラ深瀬 on 20/12/24.
//

import Foundation
import CoreMotion

final class CoreMotionManagerStub: CMMotionManager {
    var startAccelerometerUpdatesCalledCount = 0
    var startGyroUpdatesCalledCount = 0
    var stopAccelerometerUpdatesCalledCount = 0
    var stopGyroUpdatesCalledCount = 0
    
    
    override func startAccelerometerUpdates(to queue: OperationQueue, withHandler handler: @escaping CMAccelerometerHandler) {
        startAccelerometerUpdatesCalledCount += 1
    }
    
    override func startGyroUpdates(to queue: OperationQueue, withHandler handler: @escaping CMGyroHandler) {
        startGyroUpdatesCalledCount += 1
    }
    
    override func stopAccelerometerUpdates() {
        stopAccelerometerUpdatesCalledCount += 1
    }
    
    override func stopGyroUpdates() {
        stopGyroUpdatesCalledCount += 1
    }
}
