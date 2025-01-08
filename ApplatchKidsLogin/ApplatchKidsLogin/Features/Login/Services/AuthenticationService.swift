//
//  AuthenicationService.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//

import Foundation
import Combine

protocol AuthenticationServiceProtocol {
    func login(with credentials: LoginCredentials) -> AnyPublisher<Bool, Error>
}

final class AuthenticationService: AuthenticationServiceProtocol {
    func login(with credentials: LoginCredentials) -> AnyPublisher<Bool, Error> {
        // Simulate network request
        return Future<Bool, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Add your actual authentication logic here
                if credentials.email.contains("@") && credentials.password.count >= 8 {
                    promise(.success(true))
                } else {
                    promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

