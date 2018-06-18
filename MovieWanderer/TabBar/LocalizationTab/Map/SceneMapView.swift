//
//  MapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift


class SceneMapView: UIView {
    
    fileprivate let carouselView = SceneCarouselView(scenes: [Scene]())
    fileprivate let mapView = MapView()
    
    fileprivate let disposeBag = DisposeBag()
    
    var scenes = [Scene]() {
        didSet {
           mapView.scenes = scenes
            carouselView.setScenes(scenes: scenes)
        }
    }

    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        
        backgroundColor = .gray
        
        setMapView()
        setCarouselView()
        
        carouselView.scrolledToScene$
            .subscribe(onNext: { [unowned self] scene in
                self.mapView.moveCameraToScene(scene: scene)
            }).disposed(by: disposeBag)
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension SceneMapView {
    
    func setCarouselView() {
        addSubview(carouselView)
        
        carouselView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(50) //tabbar height change
            make.height.equalTo(240)
        }
        
    }
    
    func setMapView() {
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


}




