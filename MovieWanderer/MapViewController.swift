//
//  MapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 10.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

final class MapViewController: UIViewController {
    
    var closeButtonTapped$: Observable<()> {
        return closeButton.rx.tap.asObservable()
    }
    
    private let viewModel : MapViewModel
    private var annotations = [MKAnnotation]()
    private let mapView = MapView()
    private let closeButton = UIButton()
    private var scenesCarousel: InfoSceneCarouselView!
    private let disposeBag = DisposeBag()

    init(viewModel: MapViewModel) {
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
    }
}

private extension MapViewController {
    
    private func setupViews(){
        view.backgroundColor = UIColor.white
        
        mapView.viewModel = MapViewViewModel(scenes: viewModel.scenes)
//        mapView.setupStyleWith(jsonFileName: "ultra-light-style")
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
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(scenesCarousel.snp.top)
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
        
        scenesCarousel.scrolledToScene$
            .subscribe(onNext: { [unowned self] scene in
                self.mapView.highlight(scene)
            }).disposed(by: disposeBag) // use dispose bag of the cell?
        
        mapView.sceneSelected$
            .subscribe(onNext: { [unowned self] index in
                self.scenesCarousel.scrollToIndex(index)
            }).disposed(by: disposeBag)
    }
}

