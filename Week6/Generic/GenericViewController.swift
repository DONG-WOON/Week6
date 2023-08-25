//
//  GenericViewController.swift
//  Week6
//
//  Created by 서동운 on 8/24/23.
//

import UIKit

class GenericViewController: UIViewController {
    
    let aView = UIView(.red)
    let label = UILabel(.brown)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Generic"

        let sum = sum(1.2, 2.3)
        
        configureBorder(view: aView)
        configureBorder(view: label)
        
        configureViews()
        configureViewConstraints()
    }
}

extension GenericViewController: ConfigureViewProtocol {
    func configureViews() {
        view.addSubview(aView)
        view.addSubview(label)
    }
    
    func configureViewConstraints() {
        aView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(100)
            make.height.equalTo(100)
        }
        
        label.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(100)
            make.height.equalTo(100)
        }
    }
}
