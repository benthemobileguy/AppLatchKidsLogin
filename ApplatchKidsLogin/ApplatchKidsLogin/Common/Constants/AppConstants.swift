//
//  AppConstants.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/8/25.
//
// MARK: - Common/Constants/AppConstants.swift

import UIKit

struct AppConstants {
    // MARK: - UI Constants
    struct UI {
        static let cornerRadius: CGFloat = 8.0
        static let padding: CGFloat = 16.0
        static let buttonHeight: CGFloat = 50.0
        static let textFieldHeight: CGFloat = 44.0
        static let spacing: CGFloat = 16.0
        
        // Font Sizes
        static let titleFontSize: CGFloat = 28.0
        static let bodyFontSize: CGFloat = 16.0
        static let smallFontSize: CGFloat = 14.0
        
        // Animation Durations
        static let defaultAnimationDuration: TimeInterval = 0.3
    }
    
    // MARK: - Validation Constants
    struct Validation {
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let minimumPasswordLength = 8
    }
    
    // MARK: - Accessibility Identifiers
    struct AccessibilityID {
        // Login Screen
        static let titleLabel = "titleLabel"
        static let emailTextField = "emailTextField"
        static let passwordTextField = "passwordTextField"
        static let errorLabel = "errorLabel"
        static let loginButton = "loginButton"
        static let forgotPasswordButton = "forgotPasswordButton"
        static let googleLoginButton = "googleLoginButton"
        static let appleLoginButton = "appleLoginButton"
        static let activityIndicator = "activityIndicator"
        static let dividerStack = "dividerStack"
        static let orLabel = "orLabel"
    }
    
    // MARK: - Error Messages
    struct ErrorMessages {
        static let invalidEmail = "Please enter a valid email address"
        static let invalidPassword = "Password must be at least \(Validation.minimumPasswordLength) characters"
        static let emptyEmail = "Email is required"
        static let emptyPassword = "Password is required"
        static let generalError = "Something went wrong. Please try again."
    }
}
