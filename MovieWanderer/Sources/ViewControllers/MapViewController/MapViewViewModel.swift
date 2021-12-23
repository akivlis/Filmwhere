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
    var imageURL: URL?

    init(scene: Scene) {
        coordinate = CLLocationCoordinate2D(latitude: scene.location.latitude,
                                            longitude: scene.location.longitude)
        title = scene.title
        subtitle = scene.locationName
        imageURL = scene.movieURL
    }
}

struct MapViewViewModel {
    
    let annotations: [SceneAnnotation] //TODO: rewrite to dictionary

    private let scenes : [Scene]
    
    init(scenes: [Scene]) {
        self.scenes = scenes
        annotations = scenes.map { SceneAnnotation.init(scene: $0) }
    }
    
    func getAnnotationForScene(_ scene: Scene) -> MKAnnotation? {
        if let index = scenes.firstIndex(where: { $0.title == scene.title }) {
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
    
    func getSceneForAnnotation(_ annotation: MKAnnotation) -> Scene? {
        if let index = annotations.firstIndex(where: { $0.title == annotation.title }) {
            return scenes[index]
        }
        return nil
    }
    
}
