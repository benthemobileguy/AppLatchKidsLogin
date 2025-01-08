//
//  CustomTextField.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//

import UIKit
import Combine

class CustomTextField: UITextField {
    
    // MARK: - Properties
    private let iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        return button
    }()
    
    // For Combine
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(placeholder: String, icon: String, isPassword: Bool = false) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        self.iconView.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        self.eyeButton.isHidden = !isPassword
        
        if isPassword {
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Background and border
        backgroundColor = UIColor(red: 0.06, green: 0.06, blue: 0.12, alpha: 1.0)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        layer.cornerRadius = 12
        
        // Text style
        textColor = .white
        tintColor = .white
        font = .systemFont(ofSize: 16)
        
        // Add subviews
        addSubview(iconView)
        addSubview(eyeButton)
        
        // Make sure subviews don't interfere with text field interaction
        iconView.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Icon constraints
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            // Eye button constraints
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            eyeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            eyeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Text Rect Overrides
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(
            top: 0,
            left: 50,
            bottom: 0,
            right: eyeButton.isHidden ? 16 : 50
        ))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // MARK: - Password Toggle
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

