//
//  KakaoProfileButton.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

class KakaoProfileButton: UIButton {
    
    init(image: UIImage?, title: String, imagePadding: CGFloat) {
        var buttonConfig = UIButton.Configuration.plain()
        
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        buttonConfig.imagePadding = imagePadding
    
        buttonConfig.imagePlacement = .top
        buttonConfig.preferredSymbolConfigurationForImage = symbolConfig
        buttonConfig.image = image
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 12)
        
        buttonConfig.baseForegroundColor = .white
        buttonConfig.titleAlignment = .center
        buttonConfig.attributedTitle = AttributedString(title, attributes: titleContainer)
        
        super.init(frame: .zero)
        
        self.configuration = buttonConfig
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
