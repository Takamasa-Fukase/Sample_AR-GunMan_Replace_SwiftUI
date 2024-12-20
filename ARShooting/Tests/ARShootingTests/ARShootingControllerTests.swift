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
}
