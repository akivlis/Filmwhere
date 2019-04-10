//
//  SceneAnnotationView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import MapKit
import RxSwift

class SceneAnnotationView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            if (newValue as? SceneAnnotation) != nil {
                clusteringIdentifier = MKMapViewDefaultAnnotationViewReuseIdentifier
                markerTintColor = .brightPink
                glyphImage = UIImage(named: "projector")
            }
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let navigateButton = UIButton(type: .detailDisclosure)
        let image = UIImage(named: "navigation_icon")?.withRenderingMode(.alwaysTemplate)
        navigateButton.setImage(image, for: .normal)
        navigateButton.tintColor = .brightPink
        rightCalloutAccessoryView = navigateButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

