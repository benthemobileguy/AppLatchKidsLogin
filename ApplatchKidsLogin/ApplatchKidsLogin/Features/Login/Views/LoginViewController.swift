//
//  LoginViewController.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//

// MARK: - LoginViewController.swift
import UIKit
import Combine

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.configure(
            placeholder: "Enter email",
            icon: "email",
            isPassword: false
        )
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.configure(
            placeholder: "Password",
            icon: "password",
            isPassword: true
        )
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var dividerStack: UIStackView = {
        let line1 = createDividerLine()
        let line2 = createDividerLine()
        
        let orLabel = UILabel()
        orLabel.text = "or"
        orLabel.textColor = .white
        orLabel.font = .systemFont(ofSize: 14)
        orLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [line1, orLabel, line2])
        stack.axis = .horizontal

        stack.distribution = .fillEqually
        stack.alignment = .center
        orLabel.setContentHuggingPriority(.required, for: .horizontal)
        orLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        line1.setContentHuggingPriority(.defaultLow, for: .horizontal)
        line2.setContentHuggingPriority(.defaultLow, for: .horizontal)
            
        return stack
    }()
    
    private func createDividerLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }
    
    private lazy var googleLoginButton = SocialLoginButton(type: .google)
    private lazy var appleLoginButton = SocialLoginButton(type: .apple)
    
    // MARK: - Initialization & Lifecycle
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupBindings()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.06, blue: 0.12, alpha: 1.0)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        [titleLabel, emailTextField, passwordTextField, forgotPasswordButton,
         loginButton, dividerStack, googleLoginButton, appleLoginButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                
                emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
                emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                emailTextField.heightAnchor.constraint(equalToConstant: 52),
                
                passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
                passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                passwordTextField.heightAnchor.constraint(equalToConstant: 52),
                
                forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
                forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                
                loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
                loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                loginButton.heightAnchor.constraint(equalToConstant: 52),
                
                dividerStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
                dividerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                dividerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                
                appleLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
                appleLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                appleLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                appleLoginButton.heightAnchor.constraint(equalToConstant: 52),
                
                googleLoginButton.bottomAnchor.constraint(equalTo: appleLoginButton.topAnchor, constant: -16),
                googleLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                googleLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                googleLoginButton.heightAnchor.constraint(equalToConstant: 52)
            ])
        }
    
    private func setupBindings() {
      
    }
}
