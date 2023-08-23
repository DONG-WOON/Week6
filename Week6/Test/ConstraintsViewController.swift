//
//  ConstraintsViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

class ConstraintsViewController: UIViewController {
    
    let passwordTextField = UITextField()
    let button = UIButton()
    let signButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(passwordTextField)
        passwordTextField.addSubview(button)
        passwordTextField.backgroundColor = .systemIndigo
        
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.backgroundColor = .white
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        signButton.addTarget(self, action: #selector(goToSnapVC), for: .touchUpInside)
    
        
        // 1. frame
//        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width, height: 50)
        
        // 2. NSLayoutConstraint
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 50).isActive = true
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -50).isActive = true
        
        // 3. addConstraints
        
        let leadingConstraints = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 50)
        let trailingConstraints = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -50)
        let heightConstraints = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 60)
        let topConstraints = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 60)
        
        // 부모 뷰를 기준으로 잡아야함.
        view.addConstraints([leadingConstraints,
                                          trailingConstraints,
                                         heightConstraints,
                                         topConstraints])
        
        let centerY = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: passwordTextField, attribute: .centerY, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: passwordTextField, attribute: .trailing, multiplier: 1.0, constant: -10)
        
        passwordTextField.addConstraints([centerY, trailing])
        
        // 4. NSLayoutAnchor + NSLayoutConstraint
        setLayoutAnchor()
    }
    
    @objc
    func goToSnapVC() {
        let vc = SnapViewController()
        present(vc, animated: true)
    }

    func setLayoutAnchor() {
        view.addSubview(signButton)
        
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .orange
        signButton.setTitle("버튼", for: .normal)
        
        NSLayoutConstraint.activate([
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300)

        ])
    }
}

