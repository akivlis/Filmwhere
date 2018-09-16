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
    
    var sceneSelected$ : Observable<Int> {
        return sceneSelected
    }
    
    var viewModel : MapViewViewModel = MapViewViewModel(places: [Place]()) {
        didSet {
            showAnnotationsAndZoom()
        }
    }
    
    private let sceneSelected = PublishSubject<Int>()
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
        mapView.selectAnnotation(mapView.annotations[index], animated: false)
    }
    
    func highlight(_ scene: Place) {
        let coordinates = CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude)
        mapView.setCenter(coordinates, animated: true)
        
        if let annotation = viewModel.getAnnotationForScene(scene) {
            mapView.selectAnnotation(annotation, animated: true)
            //TODO: implement custom highligting, do nt call select cause the observable emits
        }
        print("Highlight scene: \(scene.title)")
    }
    
    func setupStyleWith(jsonFileName: String) {
        configureTileOverlayWith(jsonFileName: jsonFileName)
    }
}

// MARK: MKMapViewDelegate

extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        if let sceneAnnotation = annotation as? SceneAnnotation {
            let identifier = "scene"
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomMarkerAnnotionView ?? CustomMarkerAnnotionView(annotation: nil, reuseIdentifier: identifier)
            annotationView.annotation = sceneAnnotation
            annotationView.clusteringIdentifier = identifier
            annotationView.markerTintColor = .black
            let image = UIImage(named: "projector")
            annotationView.glyphImage = image
//            annotationView.selectedGlyphImage = image
            return annotationView
        }
        
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let identifier = "cluster"
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomMarkerAnnotionView ?? CustomMarkerAnnotionView(annotation: nil, reuseIdentifier: identifier)
            annotationView.annotation = clusterAnnotation
            annotationView.markerTintColor = .black
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("selected \(String(describing: view.annotation?.title))")
        view.setSelected(true, animated: false)
        view.isHighlighted  = true
        
        if let customMarker = view as? CustomMarkerAnnotionView {
            customMarker.markerTintColor = .black
        }
        
        //maybe just use idex
        if let index = viewModel.getIndexForAnnotation(view.annotation!) {
            sceneSelected.onNext(index)
        }
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
        mapView.showAnnotations(viewModel.annotations, animated: false)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,                                                                 regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: false)
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


class CustomMarkerAnnotionView: MKMarkerAnnotationView {
    
    override var isSelected: Bool {
        didSet {
            markerTintColor = .black
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
