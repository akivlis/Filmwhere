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
    
    var presentMapsActionSheet$: Observable<UIAlertController> {
        return presentMapsActionSheet
    }
    
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
    
    private let sceneSelected = PublishSubject<Int>()
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private let mapView = MKMapView()
    private let presentMapsActionSheet = PublishSubject<UIAlertController>()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init(viewModel: MapViewViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: public methods
    
    func highlightSceneOnIndex(_ index: Int) {
        mapView.selectAnnotation(mapView.annotations[index], animated: false)
    }
    
    func highlight(_ scene: Scene) {
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? SceneAnnotation {
            openMapsFor(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let customView = view as? MKMarkerAnnotationView {
            customView.markerTintColor = .darkBordo
            
            // select whole cluster when scrolled to a specific scene
            if let cluster = customView.cluster {
                if let clusterView = cluster as? ClusterAnnotationView {
                    clusterView.markerTintColor = .darkBordo

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
            customView.markerTintColor = .darkBordo
            
            if let cluster = customView.cluster {
                if let clusterView = cluster as? ClusterAnnotationView {
                    clusterView.markerTintColor = .darkBordo
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

private extension MapView {
    
    private func commonInit() {
        setupMapView()
        registerAnnotationViewClasses()
//        setupStyleWith(jsonFileName: "ultra-light-style")
    }
    
    private func setupMapView() {
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
    
    private func configureTileOverlayWith(jsonFileName: String) {
        guard let overlayFileURLString = Bundle.main.path(forResource: jsonFileName, ofType: "json") else {
            return
        }
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            return
        }
        mapView.addOverlay(tileOverlay)
    }
    
    private func openMapsFor(_ sceneAnnotation: SceneAnnotation) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open in Apple Maps",
                                      style: .default,
                                      handler: { [weak self ] _ in
            self?.openAppleMapsFor(sceneAnnotation)
        }))
        alert.addAction(UIAlertAction(title: "Open in Google Maps",
                                      style: . default,
                                      handler: { [weak self ] _ in
            self?.openGoogleMapsFor(sceneAnnotation)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        presentMapsActionSheet.onNext(alert)
    }
    
    private func openAppleMapsFor(_ sceneAnnotation: SceneAnnotation) {
        let coordinates = sceneAnnotation.coordinate
        let regionDistance : CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options: [String: Any] = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
            MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = sceneAnnotation.subtitle
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func openGoogleMapsFor(_ sceneAnnotation: SceneAnnotation) {
        let coordinates = sceneAnnotation.coordinate

        let urlString = "comgooglemaps://?center=\(coordinates.latitude),\(coordinates.longitude)&zoom=14&views=traffic&q=\(coordinates.latitude),\(coordinates.longitude)"
        if let googleUrl = URL(string: urlString) {
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.open(googleUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(coordinates.latitude),\(coordinates.longitude)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
                print("Can't use comgooglemaps://")
            }
        }
    }
}


