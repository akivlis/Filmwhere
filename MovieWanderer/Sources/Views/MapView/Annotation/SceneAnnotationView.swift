//
//  SceneAnnotationView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import MapKit
import RxSwift

//class SceneAnnotationView: MKMarkerAnnotationView {
//
//    override var annotation: MKAnnotation? {
//        willSet {
//            if (newValue as? SceneAnnotation) != nil {
//                clusteringIdentifier = nil
////                MKMapViewDefaultAnnotationViewReuseIdentifier
////                markerTintColor = .brightPink
////                glyphImage = UIImage(named: "projector")
//            }
//        }
//    }
//
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//
//        let navigateButton = UIButton(type: .detailDisclosure)
//        let image = UIImage(named: "navigation_icon")?.withRenderingMode(.alwaysTemplate)
//        navigateButton.setImage(image, for: .normal)
//        navigateButton.tintColor = .brightPink
//        rightCalloutAccessoryView = navigateButton
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}

class SceneAnnotationView: MKAnnotationView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.brightPink
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backgroundColor = UIColor.clear
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        let navigateButton = UIButton(type: .detailDisclosure)
        let image = UIImage(named: "navigation_icon")?.withRenderingMode(.alwaysTemplate)
        navigateButton.setImage(image, for: .normal)
        navigateButton.tintColor = .brightPink
        rightCalloutAccessoryView = navigateButton
        isEnabled = true
        canShowCallout = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
  
        if let annotation = annotation as? SceneAnnotation {
            imageView.kf.setImage(with: annotation.imageURL)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderColor = UIColor.brightPink.cgColor
        imageView.layer.borderWidth = 1
    }
}

