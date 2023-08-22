//
//  WeatherTableViewCell.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit
import Kingfisher

class WeatherTableViewTextCell: UITableViewCell {
    
    let cellTextLabel = UILabel()
    let background = UIView(.white)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
        configureViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTextLabel.text = nil
    }
    
    func update(data: String) {
        self.cellTextLabel.text = data
    }

}

extension WeatherTableViewTextCell: ConfigureViewProtocol {
    func configureViews() {
        backgroundColor = .clear
        contentView.addSubview(background)
        background.layer.cornerRadius = 8
        background.addSubview(cellTextLabel)
        cellTextLabel.textColor = .black
        cellTextLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureViewConstraints() {
        
        background.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(5)
            make.leading.equalTo(contentView).inset(17)
        }
        
        cellTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}



// MARK: WeatherTableViewImageCell

class WeatherTableViewImageCell: UITableViewCell {
    
    let cellImageView = UIImageView()
    let background = UIView(.white)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
        configureViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = nil
    }
    
    func update(data: String) {
        self.cellImageView.kf.setImage(with: URL(string: data))
    }
}

extension WeatherTableViewImageCell: ConfigureViewProtocol {
    func configureViews() {
        backgroundColor = .clear
        
        contentView.addSubview(background)
        background.layer.cornerRadius = 8
        background.addSubview(cellImageView)
        cellImageView.contentMode = .scaleAspectFit
    }
    
    func configureViewConstraints() {
        background.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(5)
            make.leading.equalTo(contentView).inset(17)
        }
        
        cellImageView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(110)
            make.edges.equalToSuperview().inset(10)
        }
    }
}

