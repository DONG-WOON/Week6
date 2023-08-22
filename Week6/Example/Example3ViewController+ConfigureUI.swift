//
//  Example3ViewController+ConfigureUI.swift
//  Week6
//
//  Created by 서동운 on 8/23/23.
//

import UIKit

extension Example3ViewController: ConfigureViewProtocol {
    
    func configureViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
    }
    
    func configureViewConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(headerView.snp.bottom)
        }
    }
}
