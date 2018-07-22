//
//  ModalMapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 10.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

final class ModalMapViewController: UIViewController {
    
    var closeButtonTapped$: Observable<()> {
        return closeButton.rx.tap.asObservable()
    }
    
    var scenes = [Scene]() {
        didSet {
            showAnnotationsAndZoom()
        }
    }
    
    private var annotations = [MKAnnotation]()
    private let mapView = MKMapView()
    private let closeButton = UIButton()
    private let disposeBag = DisposeBag()
    private let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationCapturesStatusBarAppearance = true
        
        setupViews()
        setupConstraints()
        setupObservables()
        //TODO: add dark gradient to top
        
        mapView.delegate = self
//        mapView.showano
    }
}

private extension ModalMapViewController {
    
    private func showAnnotationsAndZoom() {
        let annotations: [MKAnnotation] = scenes.map { scene -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: scene.latitude, longitude: scene.longitude)
            annotation.title = scene.title
            annotation.subtitle = scene.description
            return annotation
        }
        mapView.addAnnotations(annotations)
      
//        // maybe show the closest
        if let firstScene = scenes.first {
            let coordination = CLLocationCoordinate2D(latitude: firstScene.latitude, longitude: firstScene.longitude)
            mapView.setCenter(coordination, animated: false)
        }
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,                                                                 regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor.white
        view.addSubview(mapView)
        
        if let image = UIImage(named: "close-icon") {
            closeButton.setImage(image, for: .normal)
        }
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.height.width.equalTo(25)
        }
    }
    
    private func setupObservables() {
        closeButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}

extension ModalMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? MKAnnotation else { return nil }
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
}
