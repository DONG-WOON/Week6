//
//  TextViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

class TextViewController: UIViewController {
    
    // Closure
    let closureView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    // Computed Property
    var computedView: UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    // Lazy
    lazy var lazyView = setView()
    
    // init
    let photoImageView = UIImageView(.red)
    
    let titleTextField = {
        let tf = UITextField()
        
        tf.borderStyle = .none
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.placeholder = "제목을 입력해주세요"
        tf.textAlignment = .center
        tf.font = .boldSystemFont(ofSize: 15)
        
        return tf
    }()
    
    let secondTitleTextField = {
        let tf = UITextField()
        
        tf.borderStyle = .none
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.placeholder = "제목을 입력해주세요"
        tf.textAlignment = .center
        tf.font = .boldSystemFont(ofSize: 15)
        
        return tf
    }()
    
    let dateTextField = UITextField()
    
    override func loadView() {
        super.loadView()
        
        view = UIView(.white)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        view.addSubview(secondTitleTextField)
        
        photoImageView.contentMode = .scaleAspectFit
        
        photoImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        // margin
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(50)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        // no margin
        secondTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            
        }
    }
    
    func setView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
}
