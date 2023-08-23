//
//  TheaterViewController.swift
//  Week6
//
//  Created by 서동운 on 8/23/23.
//

import UIKit
import MapKit
import CoreLocation

class TheaterViewController: UITabBarController {
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    
    let actionSheetButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.configuration?.image = UIImage(systemName: "list.bullet")
        button.configuration?.background.backgroundColor = .white
        return button
    }()
    let currentLocationButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.configuration?.image = UIImage(systemName: "location.fill")
        button.configuration?.background.backgroundColor = .white
        return button
    }()
    
    private var theaterAnnotations = {
        TheaterList().mapAnnotations.map {
            let annotation = MKPointAnnotation()
            annotation.title = $0.location
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude,
                                                           longitude: $0.longitude)
            annotation.subtitle = $0.type.rawValue
            return annotation
        }
    }()
    private lazy var filteredAnnotations = theaterAnnotations
    
    private let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270) //새싹 영등포 캠퍼스
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        mapView.delegate = self
        mapView.addAnnotations(filteredAnnotations)
        
        addTargetToButtons()
        configureViews()
        configureViewConstraints()
        
        checkUserAllowLocationService()
    }
    
    // MARK: @objc Method
    
    @objc func currentButtonDidTapped() {
        checkUserAllowLocationService()
    }
    
    @objc func actionSheetDidTapped() {
        showActionSheet { [self] action in
            mapView.removeAnnotations(filteredAnnotations)
            
            let annotations = theaterAnnotations.filter{ $0.subtitle == action.title }
            
            filteredAnnotations = !annotations.isEmpty ? annotations : theaterAnnotations
            
            mapView.addAnnotations(filteredAnnotations)
        }
    }
    
    // MARK: CLLocationManager
    
    func checkUserAllowLocationService() {
        DispatchQueue.global().async { [self] in
            guard CLLocationManager.locationServicesEnabled() else {
                DispatchQueue.main.async {
                    self.showRequestLocationServiceAlert()
                }
                return
            }
            
            let authStatus: CLAuthorizationStatus
            
            if #available(iOS 14.0, *) {
                authStatus = locationManager.authorizationStatus
            } else {
                authStatus = CLLocationManager.authorizationStatus()
            }
            
            handleLocationAuth(status: authStatus)
        }
    }
    
    func handleLocationAuth(status authStatus: CLAuthorizationStatus) {
        DispatchQueue.main.async { [self] in
            switch authStatus {
            case .notDetermined, .restricted:
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
            case .denied:
                setMapViewRegion(coordinate: defaultCoordinate)
                showRequestLocationServiceAlert()
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                locationManager.startUpdatingLocation()
            @unknown default:
                print("Auth Status 새롭게 추가됨.")
            }
        }
    }
    
    // MARK: MapView
    
    func setMapViewRegion(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 6000, longitudinalMeters: 6000)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate

extension TheaterViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserAllowLocationService()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            print("location last is nil")
            return
        }
        let coordinate = location.coordinate
        
        setMapViewRegion(coordinate: coordinate)
        manager.stopUpdatingLocation()
    }
}

// MARK: - MKMapViewDelegate

extension TheaterViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        return
    }
}
// MARK: - ConfigureViewProtocol

extension TheaterViewController: ConfigureViewProtocol {
    
    func configureViews() {
        view.addSubview(mapView)
        
        mapView.addSubview(currentLocationButton)
        mapView.addSubview(actionSheetButton)
    }
    func configureViewConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(15)
        }
        actionSheetButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
        }
    }
}
extension TheaterViewController {
    
    private func addTargetToButtons() {
        currentLocationButton.addTarget(self, action: #selector(currentButtonDidTapped), for: .touchUpInside)
        actionSheetButton.addTarget(self, action: #selector(actionSheetDidTapped), for: .touchUpInside)
    }
    
    func showActionSheet(completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "영화관", message: nil, preferredStyle: .actionSheet)
        let actions = TheaterType.allCases.map { UIAlertAction(title: $0.rawValue, style: .default) { action in completion(action) } }
        let all = UIAlertAction(title: "전체보기", style: .default) { action in completion(action) }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(all)
        actions.forEach { alert.addAction($0)}
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
