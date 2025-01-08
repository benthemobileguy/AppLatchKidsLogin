//
//  LoginErrorStatesUITests.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//

import XCTest

final class LoginErrorStatesUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    func testEmptyFieldsError() {
        // Given
        let loginButton = app.buttons["loginButton"]
        
        // When
        loginButton.tap()
        
        // Then
        let errorLabel = app.staticTexts["errorLabel"]
        XCTAssertTrue(errorLabel.exists)
    }
    
    func testShortPasswordError() {
        // Given
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        // When
        emailTextField.tap()
        emailTextField.typeText("test@example.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("short")
        
        loginButton.tap()
        
        // Then
        let errorLabel = app.staticTexts["errorLabel"]
        XCTAssertTrue(errorLabel.exists)
        XCTAssertTrue(errorLabel.label.contains("Password must be at least"))
    }
}
