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
    
    override var annotation: MKAnnotation? {
        willSet {
            if (newValue as? MKClusterAnnotation) != nil {
                clusteringIdentifier = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
                markerTintColor = .darkBordo
                glyphImage = UIImage(named: "projector")
            }
        }
    }
}
