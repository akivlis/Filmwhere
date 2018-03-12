//
//  MapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import GoogleMaps


class MapView: GMSMapView {
    
    private let locationManager = CLLocationManager()
    
    fileprivate let carouselView = SceneCarouselView(scenes: [Scene]())
    
    var scenes = [Scene]() {
        didSet {
            for scene in scenes {
                showMarker(for: scene)
            }
            carouselView.setScenes(scenes: scenes)
        }
    }

    
    override init(frame: CGRect) {
        
//        scenes = [Scene]()
        super.init(frame: .zero)
        
        backgroundColor = .gray
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        setStyle()
        
        setCarouselView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
    }
    
    func setCarouselView() {
        
        addSubview(carouselView)

        carouselView.autoPinEdge(toSuperviewEdge: .left)
        carouselView.autoPinEdge(toSuperviewEdge: .right)
        carouselView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 50) //tabbar height
        carouselView.autoSetDimension(.height, toSize: 240)
    }

    
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        UIView.animate(withDuration: 5.0, animations: { () -> Void in
//            self.londonView?.tintColor = .blue
//        }, completion: {(finished) in
//            // Stop tracking view changes to allow CPU to idle.
//            self.london?.tracksViewChanges = false
//        })
//    }
}

fileprivate extension MapView {
    
    

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


