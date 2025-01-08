//
//  SocialLoginUITests.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/8/25.
//

import XCTest

final class SocialLoginUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    func testGoogleLoginFlow() {
        let googleButton = app.buttons["googleLoginButton"]
        XCTAssertTrue(googleButton.exists)
        googleButton.tap()
        // Add assertions for Google login flow
    }
    
    func testAppleLoginFlow() {
        let appleButton = app.buttons["appleLoginButton"]
        XCTAssertTrue(appleButton.exists)
        appleButton.tap()
        // Add assertions for Apple login flow
    }
}
