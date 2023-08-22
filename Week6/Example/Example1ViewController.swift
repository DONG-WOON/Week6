//
//  Example1ViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit
import SnapKit

class Example1ViewController: UIViewController {
    
    let photoImageView = UIImageView(.lightGray)
    let titleTextField = UITextField()
    let dateTextField = UITextField()
    let contentsTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureViewConstraints()
    }
}

extension Example1ViewController: ConfigureViewProtocol {
    
    func configureViews() {
        titleTextField.rounded(cornerRadius: 5)
        dateTextField.rounded(cornerRadius: 5)
        contentsTextView.rounded(cornerRadius: 5)
        
        titleTextField.placeholder = "제목을 입력해주세요."
        titleTextField.textAlignment = .center
        dateTextField.placeholder = "날짜를 입력해주세요."
        dateTextField.textAlignment = .center
    }
    
    func configureViewConstraints() {
        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        view.addSubview(dateTextField)
        view.addSubview(contentsTextView)
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.trailingMargin.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(photoImageView)
            make.height.equalTo(50)
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(photoImageView)
            make.height.equalTo(50)
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(photoImageView)
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
    }
}
