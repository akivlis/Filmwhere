//
//  WandererMapView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 18.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//


import UIKit
import MapKit
import RxSwift
import MapKitGoogleStyler

class MapView: UIView {
    
    var viewModel : MapViewViewModel = MapViewViewModel(scenes: [Scene]()) {
        didSet {
            showAnnotationsAndZoom()
        }
    }
    
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private let regionRadius: CLLocationDistance = 10000
    private let mapView = MKMapView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
    }
    
    init(viewModel: MapViewViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMapView()
    }
    
    // MARK: public methods
    
    func highlightSceneOnIndex(_ index: Int) {
        mapView.selectAnnotation(mapView.annotations[index], animated: true)
    }
    
    func highlight(_ scene: Scene) {
        let coordinates = CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude)
        mapView.setCenter(coordinates, animated: true)
        
        
        print("Highlight scene: \(scene.title)")
        if let firstAnnotation = mapView.annotations.first {
            mapView.selectAnnotation(firstAnnotation, animated: true)
        }
    }
    
    func setupStyleWith(jsonFileName: String) {
        configureTileOverlayWith(jsonFileName: jsonFileName)
    }
    
}

// MARK: MKMapViewDelegate

extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint.zero
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("selected \(view.annotation?.title)")
        view.setSelected(true, animated: true)
        view.isHighlighted  = true
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}

private extension MapView {
    
    private func setupMapView() {
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mapView.delegate = self
    }
    
    private func showAnnotationsAndZoom() {
        
        mapView.addAnnotations(viewModel.annotations)
        //        // maybe show the closest
//        if let firstScene = viewModel.scenes.first {
//            let coordination = CLLocationCoordinate2D(latitude: firstScene.latitude, longitude: firstScene.longitude)
//            mapView.setCenter(coordination, animated: false)
//        }
        
        mapView.showAnnotations(viewModel.annotations, animated: true)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,                                                                 regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func configureTileOverlayWith(jsonFileName: String) {
        guard let overlayFileURLString = Bundle.main.path(forResource: jsonFileName, ofType: "json") else {
            return
        }
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            return
        }
        mapView.add(tileOverlay)
    }
}


