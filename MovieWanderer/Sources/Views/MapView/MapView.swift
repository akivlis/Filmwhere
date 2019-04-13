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
  
    var sceneSelected$ : Observable<Int> {
        return sceneSelected
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
    
    private let sceneSelected = PublishSubject<Int>()
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private let mapView = MKMapView()
    private let navigationModelController : MapNavigationModelController
    
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
    
    // MARK: public methods
    
    func highlightSceneOnIndex(_ index: Int) {
        mapView.selectAnnotation(mapView.annotations[index], animated: false)
    }
    
    func highlight(_ scene: Scene) {
        let coordinates = CLLocationCoordinate2D(latitude: scene.location.latitude,
                                                 longitude: scene.location.longitude)
        mapView.setCenter(coordinates, animated: true)
        
        if let annotation = viewModel.getAnnotationForScene(scene) {
            mapView.selectAnnotation(annotation, animated: true)
            
            //TODO: implement custom highligting, do nt call select cause the observable emits
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
//            annotation.
            return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        }
        
        return nil

    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? SceneAnnotation {
            navigationModelController.openMapsFor(annotation.coordinate, with: annotation.subtitle)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let customView = view as? MKMarkerAnnotationView {
            customView.markerTintColor = .brightPink
            
            // select whole cluster when scrolled to a specific scene
            if let cluster = customView.cluster {
                if let clusterView = cluster as? ClusterAnnotationView {
                    clusterView.markerTintColor = .brightPink

                    let annotationFromCluster = clusterView.annotation
                    let annotationFromClick = view.annotation
                    print("the same: \(annotationFromCluster?.title == annotationFromClick?.title)")
                }
                cluster.setSelected(true, animated: true)
            }
        }
        
        //maybe just use idex
        if let index = viewModel.getIndexForAnnotation(view.annotation!) {
            sceneSelected.onNext(index)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let customView = view as? MKMarkerAnnotationView {
            customView.markerTintColor = .brightPink
            
            if let cluster = customView.cluster {
                if let clusterView = cluster as? ClusterAnnotationView {
                    clusterView.markerTintColor = .brightPink
                }
                cluster.setSelected(false, animated: true)
            }
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




