//
//  CustomTextField.swift
//  Week6
//
//  Created by 서동운 on 8/24/23.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)

        self.borderStyle = .none
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.placeholder = placeholder
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) { // coder: UINibDecoder
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
