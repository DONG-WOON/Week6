//
//  LocationViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: UIViewController {
   
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization()
    }
    
    func checkRegionAndAnnotation(coordinate: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.title = "영캠이에유"
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func checkDeviceLocationAuthorization() {
        
        // iOS 위치 서비스 활성화 체크
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authStatus: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authStatus = self.locationManager.authorizationStatus
                } else {
                    authStatus = CLLocationManager.authorizationStatus()
                }
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authStatus)
                }
                
            } else {
                print("위치 서비스 꺼져 있어서 위치권한 설정을 못함.")
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.requestAlwaysAuthorization()
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
        checkDeviceLocationAuthorization()
    }
    
    // 사용자이 위치를 성공적으로 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate = locations.last?.coordinate else { return }
        checkRegionAndAnnotation(coordinate: coordinate)
        // 한번만 업데이트를 원하는 경우
        manager.stopUpdatingLocation()
        return
    }
    
    // 사용자의 위치를 가져오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        return
    }
}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
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
