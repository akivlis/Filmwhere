//
//  ModalMapViewModel.swift
//  MovieWanderer
//
//  Created by Silvika on 22/07/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import MapKit

struct ModalMapViewModel {
    
    let scenes : [Scene]
    
    var annotations: [MKAnnotation] {
        return scenes.map { scene -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude)
            annotation.title = scene.title
            annotation.subtitle = scene.description
            return annotation
        }
    }
}
