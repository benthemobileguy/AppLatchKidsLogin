//
//  MockAuthenticationService.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/8/25.
//

import Foundation
import Combine
@testable import ApplatchKidsLogin

final class MockAuthenticationService: AuthenticationServiceProtocol {
    var loginResult: Result<Bool, Error>?
    
    func login(with credentials: LoginCredentials) -> AnyPublisher<Bool, Error> {
        guard let result = loginResult else {
            fatalError("loginResult not set")
        }
        
        return result.publisher
            .delay(for: .milliseconds(100), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

