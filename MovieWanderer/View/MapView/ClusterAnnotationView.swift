//
//  ClusterAnnotationView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

import MapKit

class ClusterAnnotationView: MKMarkerAnnotationView {
    
    override var isSelected: Bool {
        didSet {
            markerTintColor = .yellow
        }
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if (newValue as? MKClusterAnnotation) != nil {
                clusteringIdentifier = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
                markerTintColor = .black
                glyphImage = UIImage(named: "projector")
            }
        }
    }
}
