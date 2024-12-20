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
        super.startAccelerometerUpdates(to: queue, withHandler: handler)
        startAccelerometerUpdatesCalledCount += 1
    }
    
    override func startGyroUpdates(to queue: OperationQueue, withHandler handler: @escaping CMGyroHandler) {
        super.startGyroUpdates(to: queue, withHandler: handler)
        startGyroUpdatesCalledCount += 1
    }
    
    override func stopAccelerometerUpdates() {
        super.stopAccelerometerUpdates()
        stopAccelerometerUpdatesCalledCount += 1
    }
    
    override func stopGyroUpdates() {
        super.stopGyroUpdates()
        stopGyroUpdatesCalledCount += 1
    }
}
