//
//  UIImage+SVG.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/8/25.
//

import UIKit
import WebKit

extension UIImage {
    static func fromSVG(_ svgString: String, size: CGSize) -> UIImage? {
        let svgTemplate = """
        <svg width="\(size.width)" height="\(size.height)">
            \(svgString)
        </svg>
        """
        
        let webView = WKWebView(frame: CGRect(origin: .zero, size: size))
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        
        webView.loadHTMLString(svgTemplate, baseURL: nil)
        
        let imageRenderer = UIGraphicsImageRenderer(size: size)
        return imageRenderer.image { _ in
            webView.layer.render(in: UIGraphicsGetCurrentContext()!)
        }
    }
}
