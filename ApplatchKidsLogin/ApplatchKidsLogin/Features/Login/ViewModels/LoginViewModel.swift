//
//  LoginViewModel.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//

import Foundation
import Combine

final class LoginViewModel {
    // MARK: - Published Properties
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: String?
    @Published var isLoggedIn = false
    
    // MARK: - Private Properties
    private let authService: AuthenticationServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.authService = authService
    }
    
    // MARK: - Public Methods
    func login() {
        guard validateInput() else { return }
        
        isLoading = true
        error = nil
        
        let credentials = LoginCredentials(email: email, password: password)
        
        authService.login(with: credentials)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                self?.isLoggedIn = success
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Private Methods
    private func validateInput() -> Bool {
        guard isValid(email: email) else {
            error = "Please enter a valid email address"
            return false
        }
        
        guard password.count >= AppConstants.Validation.minimumPasswordLength else {
            error = "Password must be at least \(AppConstants.Validation.minimumPasswordLength) characters"
            return false
        }
        
        return true
    }
    
    func isValid(email: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", AppConstants.Validation.emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
