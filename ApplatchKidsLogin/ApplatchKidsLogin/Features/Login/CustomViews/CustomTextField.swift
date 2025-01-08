//
//  CustomTextField.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/7/25.
//


import UIKit
import Combine

final class CustomTextField: UITextField {
    // MARK: - Properties
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(white: 1, alpha: 0.3)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let showPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = UIColor(white: 1, alpha: 0.3)
        button.isHidden = true
        return button
    }()
    
    var showPasswordTapped: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(title: String, icon: String, isPassword: Bool = false) {
        titleLabel.text = title
        iconView.image = UIImage(systemName: icon)
        showPasswordButton.isHidden = !isPassword
        
        if isPassword {
            showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = UIColor(white: 1, alpha: 0.08)
        textColor = .white
        tintColor = .white
        font = .systemFont(ofSize: 16)
        layer.cornerRadius = 12
        
        // Add title label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add icon container
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add show password button
        addSubview(showPasswordButton)
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            
            showPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            showPasswordButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showPasswordButton.widthAnchor.constraint(equalToConstant: 24),
            showPasswordButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Text Rect
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 48, bottom: 0, right: showPasswordButton.isHidden ? 16 : 48))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 48, bottom: 0, right: showPasswordButton.isHidden ? 16 : 48))
    }
    
    // MARK: - Actions
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

