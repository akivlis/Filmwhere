//
//  WandererMapView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 18.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//


import UIKit
import GoogleMaps
import RxSwift

class MapView: GMSMapView {
    
    private let locationManager = CLLocationManager()
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let defaultZoom: Float = 13.0
    
    var scenes = [Scene]() {
        didSet {
            for scene in scenes {
                showMarker(for: scene)
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        setStyle()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveCameraToScene(scene: Scene) {
        //TODO: highlight selected scene
//                clear()
//                selectedMarker = nil
        
        let location = GMSCameraPosition.camera(withLatitude: scene.latitude, longitude: scene.longitude, zoom: defaultZoom)
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude))
        marker.map = self
        
        selectedMarker = marker
        
        animate(to: location)
    }
    
    
}

extension MapView: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        marker.opacity = 1.0
        return true
    }
}

extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        
        isMyLocationEnabled = true
        //        settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        camera = GMSCameraPosition(target: location.coordinate, zoom: defaultZoom, bearing: 0, viewingAngle: 0)
        
        
        locationManager.stopUpdatingLocation()
    }
    
}


private extension MapView {
    
    func setStyle() {
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    func showMarker(for scene: Scene) {
        
        let pinLocationImage = UIImage(named: "pin_image")!.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: pinLocationImage)
        markerView.tintColor = .red
        
        
        let position = CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude)
        let marker = GMSMarker(position: position)
        marker.title = scene.title
        marker.snippet = scene.description
        marker.map = self
        marker.iconView = markerView
        //        marker.tracksViewChanges = true
        
    }
    
}


