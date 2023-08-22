//
//  HeaderWeatherView.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

class HeaderWeatherView: UIView {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 hh시 mm분"
        
        label.text = dateFormatter.string(from: Date())
        return label
    }()
    
    let location: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        
        config.image = UIImage(systemName: "location.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        config.preferredSymbolConfigurationForImage = symbolConfig
        config.imagePadding = 10
        
        var container = AttributeContainer()
        container.foregroundColor = .white.withAlphaComponent(1)
        container.font = .systemFont(ofSize: 16, weight: .bold)
        config.attributedTitle = AttributedString("서울, 신림동", attributes: container)
        
        button.configuration = config
        button.isUserInteractionEnabled = false
        button.isEnabled = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        configureViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderWeatherView: ConfigureViewProtocol {
    func configureViews() {
        self.addSubview(dateLabel)
        self.addSubview(location)
        
        self.addSubview(shareButton)
        self.addSubview(reloadButton)
    }
    
    func configureViewConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        location.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(5)
        }
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(location)
            make.trailing.equalTo(reloadButton.snp.leading).offset(-25)
        }
        reloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(location)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
