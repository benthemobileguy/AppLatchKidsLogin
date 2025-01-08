//
//  UIColor+App.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/8/25.
//

// MARK: - Common/Extensions/UIColor+App.swift
import UIKit

extension UIColor {
    static var appBackground: UIColor {
        UIColor(red: 0.07, green: 0.07, blue: 0.15, alpha: 1.0)
    }
    
    static var appSecondary: UIColor {
        UIColor(white: 1.0, alpha: 0.1)
    }
    
    static var appText: UIColor {
        .white
    }
    
    static var appPrimary: UIColor {
        .systemBlue
    }
    
    static var appBorder: UIColor {
        UIColor(white: 1.0, alpha: 0.1)
    }
    
    static var appDivider: UIColor {
        UIColor(white: 1.0, alpha: 0.2)
    }
}
