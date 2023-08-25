//
//  Extension+UIViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

extension UIViewController: Identifiable { }

extension UIViewController {
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            guard let openSetting = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(openSetting)
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension UIViewController {

    
    // Generic: 타입에 유연하게 대응하기 위한 요소
    // 추상화
    
    // T <- Type Parameter
    // T: (Type Constraints) <- 클래스, 프로토콜 제약 추가
    
    // 제네릭은 프로토콜처럼 객체를 추상화하여 사용할 수 있는 방식으로, 클래스나 프로토콜을 제한하여 사용할 수 있도록 설정할 수도 있다.
    
    func sum<T: AdditiveArithmetic>(_ lhs: T, _ rhs: T) -> T {
        return lhs + rhs
    }
    
    func configureBorder<T: UIView>(view: T) {
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        
        if type(of: view) == UILabel.self {
            view.clipsToBounds = true
        }
    }
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFullNavigation
        case push
    }
   
    func transition<T: UIViewController>(_ vc: T, style: TransitionStyle) {
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
