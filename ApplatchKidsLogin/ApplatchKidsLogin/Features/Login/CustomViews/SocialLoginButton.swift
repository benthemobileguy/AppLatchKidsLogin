//
//  SocialLoginButton.swift
//  ApplatchKidsLogin
//
//  Created by Ben on 1/6/25.
//

import UIKit

final class SocialLoginButton: UIButton {
    
    // MARK: - Social Login Types
    enum SocialType {
        case google
        case apple
        
        var title: String {
            switch self {
            case .google: return "Continue with Google"
            case .apple: return "Continue with Apple"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .google:
                return UIImage(named: "google")
            case .apple:
                return UIImage(named: "apple")
            }
        }
    }
    
    // MARK: - Properties
    private let socialType: SocialType
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Initialization
    init(type: SocialType) {
        self.socialType = type
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Set background to match main background color
        backgroundColor = UIColor(red: 0.06, green: 0.06, blue: 0.12, alpha: 1.0)
        layer.cornerRadius = 12
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        
        customTitleLabel.text = socialType.title
        iconImageView.image = socialType.icon
        
        addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(customTitleLabel)
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // Icon constraints - left aligned
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Title label constraints - centered in remaining space
            customTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            customTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    // MARK: - Override Methods
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.alpha = self.isHighlighted ? 0.7 : 1.0
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.7
        }
    }
    
    // MARK: - Public Methods
    func setLoading(_ isLoading: Bool) {
        isEnabled = !isLoading
        customTitleLabel.text = isLoading ? "Please wait..." : socialType.title
        iconImageView.isHidden = isLoading
    }
}

