//
//  SocialLoginButton.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/7/25.
//

// MARK: - SocialLoginButton.swift
import UIKit

final class SocialLoginButton: UIButton {
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
            case .google: return UIImage(named: "google_logo")?.withRenderingMode(.alwaysOriginal)
            case .apple: return UIImage(named: "apple_logo")?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    private let socialType: SocialType
    
    init(type: SocialType) {
        self.socialType = type
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 1, alpha: 0.06)
        setTitle(socialType.title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17)
        layer.cornerRadius = 12
        
        if let icon = socialType.icon {
            setImage(icon, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        }
    }
}
