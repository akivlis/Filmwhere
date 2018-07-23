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
    
    private let viewModel : ModalMapViewModel
    private var annotations = [MKAnnotation]()
    private let mapView = MKMapView()
    private let closeButton = UIButton()
    private var scenesCarousel: InfoSceneCarouselView!
    private let disposeBag = DisposeBag()
    private let regionRadius: CLLocationDistance = 1000
    
    init(viewModel: ModalMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupObservables()
        //TODO: add dark gradient to top
        
        mapView.delegate = self
        showAnnotationsAndZoom()
    }
}

private extension ModalMapViewController {
    
    private func showAnnotationsAndZoom() {
        
        mapView.addAnnotations(viewModel.annotations)
      
//        // maybe show the closest
        if let firstScene = viewModel.scenes.first {
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
        
        scenesCarousel = InfoSceneCarouselView(scenes: viewModel.scenes)
        view.addSubview(scenesCarousel)
        
        if let image = UIImage(named: "close-icon") {
            closeButton.setImage(image, for: .normal)
        }
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.height.width.equalTo(25)
        }
        
        scenesCarousel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(250)
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
