//
//  ARShootingControllerTests.swift
//  
//
//  Created by ウルトラ深瀬 on 20/12/24.
//

import XCTest
@testable import ARShooting

final class ARShootingControllerTests: XCTestCase {
    private var arShootingController: ARShootingController!
    private var sceneManagerStub: SceneManagerStub!
    
    override func setUpWithError() throws {
        sceneManagerStub = .init()
        arShootingController = .init(sceneManager: sceneManagerStub)
    }

    override func tearDownWithError() throws {
        sceneManagerStub = nil
        arShootingController = nil
    }
    
    func test_view() {
        let view = arShootingController.view as! SceneViewRepresentable
        XCTAssertEqual(view.getView(), sceneManagerStub.dummySceneView)
    }
    
    func test_runSession() {
        XCTAssertEqual(sceneManagerStub.runSessionCalledCount, 0)
        arShootingController.runSession()
        XCTAssertEqual(sceneManagerStub.runSessionCalledCount, 1)
    }
    
    func test_pauseSession() {
        XCTAssertEqual(sceneManagerStub.pauseSessionCalledCount, 0)
        arShootingController.pauseSession()
        XCTAssertEqual(sceneManagerStub.pauseSessionCalledCount, 1)
    }
    
    func test_showWeaponObject() {
        XCTAssertEqual(sceneManagerStub.showWeaponObjectCalledValues, [])
        arShootingController.showWeaponObject(weaponId: 100)
        XCTAssertEqual(sceneManagerStub.showWeaponObjectCalledValues, [100])
    }
    
    func test_renderWeaponFiring() {
        XCTAssertEqual(sceneManagerStub.renderWeaponFiringCalledCount, 0)
        arShootingController.renderWeaponFiring()
        XCTAssertEqual(sceneManagerStub.renderWeaponFiringCalledCount, 1)
    }
    
    func test_changeTargetsAppearance() {
        XCTAssertEqual(sceneManagerStub.changeTargetsAppearanceCalledValues, [])
        arShootingController.changeTargetsAppearance(to: "test_image")
        XCTAssertEqual(sceneManagerStub.changeTargetsAppearanceCalledValues, ["test_image"])
    }
}
