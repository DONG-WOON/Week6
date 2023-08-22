//
//  Example3ViewController+CLLocation.swift
//  Week6
//
//  Created by 서동운 on 8/23/23.
//

import Foundation
import CoreLocation

extension Example3ViewController {
    
    func setUpLocationManager() {
        locationManager.delegate = self
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
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorized:
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError("권한 설정을 아무것도 설정하지않았음.")
        }
    }
}

extension Example3ViewController: CLLocationManagerDelegate {
    
    // 사용자의 권한 상태가 바뀔때 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkCurrentLocationAuthorization(status: manager.authorizationStatus)
    }
    
    // 사용자이 위치를 성공적으로 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinate = location.coordinate
        CLGeocoder().reverseGeocodeLocation(location) { (placeMarks, error) in
            guard let placeMarks = placeMarks?.first else { return }
            guard let city = placeMarks.name,
                  let country = placeMarks.country else { return }
            
            var container = AttributeContainer()
            container.foregroundColor = .white.withAlphaComponent(1)
            container.font = .systemFont(ofSize: 16, weight: .bold)
            self.headerView.location.configuration?.attributedTitle = AttributedString("\(city), \(country)", attributes: container)
        }
        callWeatherRequest(at: coordinate.latitude.description, longitude: coordinate.longitude.description)
        return
    }
    
    // 사용자의 위치를 가져오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        return
    }
}
