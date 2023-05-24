//
//  UIViewExtension.swift
//  Instamigos
//
//  Created by Cáren Sousa on 24/05/23.
//

import UIKit

extension UIView {
    func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4
        layer.shouldRasterize = true
    }
}
