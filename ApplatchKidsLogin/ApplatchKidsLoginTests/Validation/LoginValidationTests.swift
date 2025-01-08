//
//  LoginValidationTests.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/8/25.
//

import XCTest
@testable import ApplatchKidsLogin

final class LoginValidationTests: XCTestCase {
    var sut: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        sut = LoginViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testEmailValidation() {
        // Valid emails
        XCTAssertTrue(sut.isValid(email: "test@example.com"))
        XCTAssertTrue(sut.isValid(email: "user.name+tag@example.co.uk"))
        XCTAssertTrue(sut.isValid(email: "test.email@subdomain.example.com"))
        
        // Invalid emails
        XCTAssertFalse(sut.isValid(email: "invalid-email"))
        XCTAssertFalse(sut.isValid(email: "@example.com"))
        XCTAssertFalse(sut.isValid(email: "test@"))
        XCTAssertFalse(sut.isValid(email: ""))
    }
    
    func testPasswordValidation() {
        // Given
        sut.password = "short"
        
        // When
        sut.login()
        
        // Then
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(sut.error?.contains("Password must be at least") ?? false)
    }
}

