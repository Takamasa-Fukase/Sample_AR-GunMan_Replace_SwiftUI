//
//  SceneManagerStub.swift
//
//
//  Created by ウルトラ深瀬 on 20/12/24.
//

import Foundation
import ARKit
@testable import ARShooting

final class SceneManagerStub: SceneManagerInterface {
    var targetHit: (() -> Void)?
    
    func getSceneView() -> ARSCNView {
        return .init()
    }
    
    func runSession() {
        
    }
    
    func pauseSession() {
        
    }
    
    func showWeaponObject(weaponId: Int) {
        
    }
    
    func renderWeaponFiring() {
        
    }
    
    func changeTargetsAppearance(to imageName: String) {
        
    }
}
