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
    
    var scenes = [Scene]() {
        didSet {
            for scene in scenes {
                showMarker(for: scene)
            }
            showOptimalZoom()
        }
    }
    
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private let defaultZoom: Float = 13.0
    private var markers = [GMSMarker]()
    
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
        let zoom = camera.zoom
        let location = GMSCameraPosition.camera(withLatitude: scene.latitude, longitude: scene.longitude, zoom: zoom)
        
        animate(to: location)
    }
    
    func highlightMarker(for sceneIndex: Int) {
        
        for i in 0...markers.count - 1 {
            let marker = markers[i]
            if i == sceneIndex {
                marker.icon = GMSMarker.markerImage(with: .black)
            } else {
                marker.icon = GMSMarker.markerImage(with: .red)
            }
        }
    }
    
    func moveCameraToClosestScene() {
        //TODO: implement
    }
    
    func showOptimalZoom() {
        //Create a path
        let path = GMSMutablePath()

        //for each point you need, add it to your path

        let positions = scenes.map {CLLocationCoordinate2DMake($0.latitude, $0.longitude)}
        for i in 0...1 {
            path.add(positions[i])

        }

        //Update your mapView with path
        let mapBounds = GMSCoordinateBounds(path: path)
        let cameraUpdate = GMSCameraUpdate.fit(mapBounds)

//        delay(seconds: 2) { () -> () in
            moveCamera(cameraUpdate)
//        }
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
        settings.myLocationButton = false
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
//        let pinLocationImage = UIImage(named: "pin_image")!.withRenderingMode(.alwaysTemplate)
//        let markerView = UIImageView(image: pinLocationImage)
//        markerView.tintColor = .red
        
        
        let position = CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude)
        let marker = GMSMarker(position: position)
        marker.title = scene.title
        marker.snippet = scene.description
        marker.map = self
        
        markers.append(marker)

//        marker.iconView = markerView
        //        marker.tracksViewChanges = true
        
    }
    
}


