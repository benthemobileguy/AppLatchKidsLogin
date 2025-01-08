//
//  LoginViewModelTests.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//

import XCTest
import Combine
@testable import ApplatchKidsLogin

final class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModel!
    var mockAuthService: MockAuthenticationService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationService()
        sut = LoginViewModel(authService: mockAuthService)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        mockAuthService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        // Given
        mockAuthService.loginResult = .success(true)
        let expectation = expectation(description: "Login success")
        
        sut.email = "test@example.com"
        sut.password = "password123"
        
        sut.$isLoggedIn
            .dropFirst()
            .sink { isLoggedIn in
                XCTAssertTrue(isLoggedIn)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.login()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testLoginFailure() {
        // Given
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Login failed"])
        mockAuthService.loginResult = .failure(error)
        let expectation = expectation(description: "Login failure")
        
        sut.email = "test@example.com"
        sut.password = "password123"
        
        sut.$error
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Login failed")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.login()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(sut.isLoggedIn)
        XCTAssertFalse(sut.isLoading)
    }
}

