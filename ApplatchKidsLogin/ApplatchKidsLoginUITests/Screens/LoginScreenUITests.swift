//
//  LoginScreenUITests.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//

import XCTest

final class LoginScreenUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    func testLoginScreenElements() {
        XCTAssertTrue(app.textFields["emailTextField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordTextField"].exists)
        XCTAssertTrue(app.buttons["loginButton"].exists)
        XCTAssertTrue(app.buttons.matching(identifier: "googleLoginButton").firstMatch.exists)
        XCTAssertTrue(app.buttons.matching(identifier: "appleLoginButton").firstMatch.exists)
    }
    
    func testLoginFlow() {
        // Given
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        // When
        emailTextField.tap()
        emailTextField.typeText("test@example.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("password123")
        
        loginButton.tap()
        
        // Then
        let errorLabel = app.staticTexts["errorLabel"]
        XCTAssertFalse(errorLabel.exists || !errorLabel.label.isEmpty)
    }
    
    func testInvalidEmailError() {
        // Given
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        // When
        emailTextField.tap()
        emailTextField.typeText("invalid-email")
        
        passwordTextField.tap()
        passwordTextField.typeText("password123")
        
        loginButton.tap()
        
        // Then
        let errorLabel = app.staticTexts["errorLabel"]
        XCTAssertTrue(errorLabel.exists)
        XCTAssertTrue(errorLabel.label.contains("valid email"))
    }
}
