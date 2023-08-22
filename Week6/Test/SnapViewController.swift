//
//  SnapViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit
import SnapKit

/*
 addSubView hierarchy을 잘생각해서
 
 */

class SnapViewController: UIViewController {
    
    let redView = UIView(.red)
    let whiteView = UIView(.white)
    let blueView = UIView(.blue)
    let yellowView = UIView(.yellow)
    
    override func loadView() {
        super.loadView()
        
        view = UIView(.lightGray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        view.addSubview(whiteView)
        view.addSubview(blueView)
        
        blueView.addSubview(yellowView)

        redView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerX.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        whiteView.snp.makeConstraints { make in
            make.height.width.equalTo(redView)
            make.top.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        blueView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(200)
        }
        
        yellowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10).offset(50)
        }
    }
}

extension UIView {
    convenience init(_ backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
}
