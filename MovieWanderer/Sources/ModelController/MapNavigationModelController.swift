//
//  MapNavigationModelController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 10.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import MapKit

class MapNavigationModelController {
    
    var presentMapsActionSheet$: Observable<UIAlertController> {
        return presentMapsActionSheet
    }
    private let presentMapsActionSheet = PublishSubject<UIAlertController>()
    
    func openMapsFor(_ scene: Scene) {
        let coordinates = CLLocationCoordinate2D(latitude: scene.location.latitude,
                                                 longitude: scene.location.longitude)
        openMapsFor(coordinates, with: scene.locationName)
    }
    
    func openMapsFor(_ coordinates: CLLocationCoordinate2D, with locationName: String?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open in Apple Maps",
                                      style: .default,
                                      handler: { [weak self ] _ in
                                        self?.openAppleMapsFor(coordinates, locationName: locationName)
        }))
        alert.addAction(UIAlertAction(title: "Open in Google Maps",
                                      style: . default,
                                      handler: { [weak self ] _ in
                                        self?.openGoogleMapsFor(coordinates, locationName: locationName)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        presentMapsActionSheet.onNext(alert)
    }
    
    private func openAppleMapsFor(_ coordinates: CLLocationCoordinate2D, locationName: String?) {
        let regionDistance : CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options: [String: Any] = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
            MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func openGoogleMapsFor(_ coordinates: CLLocationCoordinate2D, locationName: String?) {
        let urlString = "comgooglemaps://?center=\(coordinates.latitude),\(coordinates.longitude)&zoom=14&views=traffic&q=\(coordinates.latitude),\(coordinates.longitude)"
        if let googleUrl = URL(string: urlString) {
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.open(googleUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(coordinates.latitude),\(coordinates.longitude)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
                print("Can't use comgooglemaps://")
            }
        }
    }
}
