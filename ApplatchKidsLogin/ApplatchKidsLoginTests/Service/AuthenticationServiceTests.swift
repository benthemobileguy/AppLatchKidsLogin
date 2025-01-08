//
//  AuthenticationServiceTests.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/8/25.
//

import XCTest
import Combine
@testable import ApplatchKidsLogin

final class AuthenticationServiceTests: XCTestCase {
    var sut: AuthenticationService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = AuthenticationService()
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        // Given
        let credentials = LoginCredentials(email: "test@example.com", password: "password123")
        let expectation = expectation(description: "Login success")
        
        // When
        sut.login(with: credentials)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Login should succeed")
                }
            } receiveValue: { success in
                // Then
                XCTAssertTrue(success)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testLoginFailure() {
        // Given
        let credentials = LoginCredentials(email: "invalid", password: "short")
        let expectation = expectation(description: "Login failure")
        
        // When
        sut.login(with: credentials)
            .sink { completion in
                if case .failure = completion {
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Login should fail")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}

