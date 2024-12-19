//
//  ARShootingAppController.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import UIKit
import SwiftUI

public final class ARShootingAppController {
    public var targetHit: (() -> Void)? {
        didSet {
            arController.targetHit = targetHit
        }
    }
    public var view: some View {
        return ARShootingAppView(sceneView: arController.getSceneView())
    }
    private var arController: ARController
    
    public init(frame: CGRect) {
        arController = ARController(frame: frame)
    }
    
    public func runSession() {
        arController.runSession()
    }
    
    public func pauseSession() {
        arController.pauseSession()
    }
    
    public func showWeaponObject(weaponId: Int) {
        arController.showWeaponObject(weaponId: weaponId)
    }
    
    public func renderWeaponFiring() {
        arController.renderWeaponFiring()
    }
    
    public func changeTargetsAppearance(to imageName: String) {
        arController.changeTargetsAppearance(to: imageName)
    }
}
