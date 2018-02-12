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

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .gray
        
        let pinLocationImage = UIImage(named: "pin_image")
        let imageView = UIImageView(image: pinLocationImage)
        addSubview(imageView)
        imageView.autoCenterInSuperview()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
        settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
    }
}
