//
//  Extension+UIView.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

extension UIView {
    convenience init(_ backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    func rounded(cornerRadius: CGFloat, borderColor: UIColor = .black, borderWidth: CGFloat = 1) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}
