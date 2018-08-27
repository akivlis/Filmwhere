//
//  MapViewViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 29.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import MapKit

struct MapViewViewModel {
    
    let annotations: [MKAnnotation]

    private let scenes : [Scene]
//    private var sceneAnnotation = [(Scene, MKAnnotation)]()
    
    init(scenes: [Scene]) {
        self.scenes = scenes
        
        annotations =  scenes.map { scene -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude)
            annotation.title = scene.title
            annotation.subtitle = scene.description
            return annotation
        }
        
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
    
//    func getIndexForScene(_ scene: Scene) -> Int? {
//        let index = scenes.firstIndex { $0.title == scene.title } // TODO: rewrite
//        return index
//    }
}
