//
//  SceneAnnotationView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import MapKit

class SceneAnnotationView: MKMarkerAnnotationView {
    
    override var isSelected: Bool {
        didSet {
            markerTintColor = .black
        }
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if (newValue as? SceneAnnotation) != nil {
                clusteringIdentifier = MKMapViewDefaultAnnotationViewReuseIdentifier
                markerTintColor = .black
                glyphImage = UIImage(named: "projector")
            }
        }
    }
}
