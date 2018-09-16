//
//  MapViewViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 29.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import MapKit

class SceneAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(place: Place) {
        coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        title = place.title
        subtitle = place.description
    }
}

struct MapViewViewModel {
    
    let annotations: [SceneAnnotation]

    private let places : [Place]
    
    init(places: [Place]) {
        self.places = places
        annotations = places.map { SceneAnnotation.init(place: $0) }
    }
    
    func getAnnotationForScene(_ scene: Place) -> MKAnnotation? {
        if let index = places.firstIndex(where: { $0.title == scene.title }) {
            return annotations[index]
        }
        return nil
    }
    
    func getIndexForAnnotation(_ annotation: MKAnnotation) -> Int? {
        if let index = annotations.firstIndex(where: { $0.title == annotation.title }) {
            return index
        }
        return nil
    }
    
    func getSceneForAnnotation(_ annotation: MKAnnotation) -> Place? {
        if let index = annotations.firstIndex(where: { $0.title == annotation.title }) {
            return places[index]
        }
        return nil
    }
    
}
