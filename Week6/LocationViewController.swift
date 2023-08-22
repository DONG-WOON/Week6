//
//  LocationViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit
import CoreLocation


class LocationViewController: UIViewController {
   
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization()
    
    }
    
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authStatus: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authStatus = self.locationManager.authorizationStatus
                } else {
                    authStatus = CLLocationManager.authorizationStatus()
                }
                
                self.checkCurrentLocationAuthorization(status: authStatus)
                
            } else {
                print("위치 서비스 꺼져 있어서 위치권한 설정을 못함.")
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            fatalError("권한 설정을 아무것도 설정하지않았음.")
        }
    }
}

extension LocationViewController: CLLocationManagerDelegate {
    
    // 사용자의 권한 상태가 바뀔때 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkCurrentLocationAuthorization(status: manager.authorizationStatus)
    }
    
    // 사용자이 위치를 성공적으로 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        return
    }
    
    // 사용자의 위치를 가져오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        return
    }
}

extension LocationViewController {
    func alert() {
        let alert = UIAlertController(title: "위치설정", message: "위치설정 서비스 설정", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
