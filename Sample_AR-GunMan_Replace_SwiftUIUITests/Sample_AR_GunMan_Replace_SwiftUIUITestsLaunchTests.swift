//
//  Sample_AR_GunMan_Replace_SwiftUIUITestsLaunchTests.swift
//  Sample_AR-GunMan_Replace_SwiftUIUITests
//
//  Created by ウルトラ深瀬 on 29/11/24.
//

import XCTest

final class Sample_AR_GunMan_Replace_SwiftUIUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
