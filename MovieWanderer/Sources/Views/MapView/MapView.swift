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

class MapView: UIView {
  
    var scrollToSceneIndex$ : Observable<Int> {
        return scrollToIndex
    }
    
    var viewModel : MapViewViewModel = MapViewViewModel(scenes: [Scene]()) {
        willSet {
            removeAllAnnotations()
        }
        didSet {
            showAnnotationsAndZoom()
        }
    }
    
    var presentMapsActionSheet$: Observable<UIAlertController> {
        return navigationModelController.presentMapsActionSheet$
    }
    
    private let scrollToIndex = PublishSubject<Int>()
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private let mapView = MKMapView()
    private let navigationModelController : MapNavigationModelController
    private var sceneHighlightedByScroll = false
    
    // MARK: Init
    
    init(viewModel: MapViewViewModel, navigationModelController: MapNavigationModelController) {
        self.navigationModelController = navigationModelController
        super.init(frame: .zero)
        self.viewModel = viewModel
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.navigationModelController = MapNavigationModelController()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: Public
    
    // IMPORTANT: Only call this method when scrolled to the the scene
    func highlight(_ scene: Scene) {
        let coordinates = CLLocationCoordinate2D(latitude: scene.location.latitude,
                                                 longitude: scene.location.longitude)
        mapView.setCenter(coordinates, animated: true)
        
        if let annotation = viewModel.getAnnotationForScene(scene) {
            sceneHighlightedByScroll = true
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
}

// MARK: MKMapViewDelegate

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        if let annotation = annotation as? SceneAnnotation {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
            return annotationView
        }
        return nil
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? SceneAnnotation {
            navigationModelController.openMapsFor(annotation.coordinate, with: annotation.subtitle)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let sceneAnnotationView = view as? SceneAnnotationView {
           sceneAnnotationView.scaleImage(.up)
        }
        
        // we should not scroll if the annotation was selected by scrolling already!!!
        if !sceneHighlightedByScroll {
            if let index = viewModel.getIndexForAnnotation(view.annotation!) {
                scrollToIndex.onNext(index)
            }
        }
        sceneHighlightedByScroll = false
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let sceneAnnotationView = view as? SceneAnnotationView {
            sceneAnnotationView.scaleImage(.down)
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

// MARK: - CLLocationManagerDelegate

extension MapView: CLLocationManagerDelegate {
    
}


// MARK: - Private

private extension MapView {
    
    private func commonInit() {
        setupViews()
        registerAnnotationViewClasses()
        showAnnotationsAndZoom()
        determineCurrentLocation()
    }
    
    private func setupViews() {
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mapView.delegate = self
       
    }
    
    private func registerAnnotationViewClasses() {
        mapView.register(SceneAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ClusterAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier:  MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    private func showAnnotationsAndZoom() {
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.viewModel.annotations)
            self.mapView.showAnnotations(self.viewModel.annotations, animated: true)
        }
    }
    
    private func removeAllAnnotations() {
        mapView.removeAnnotations(viewModel.annotations)
    }
    
    private func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
        
        mapView.showsUserLocation = true
    }
}




