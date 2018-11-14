//
//  MapAndScenesCarouselView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 28.08.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

final class MapAndScenesCarouselView: UIView {
    
    private let scenes: [Scene]
    private var scenesCarousel: SceneCarouselView!
    private let mapView = MapView()
    private let disposeBag = DisposeBag()
    
    init(scenes: [Scene]) {
        self.scenes = scenes
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scenes = [Scene]()
        super.init(coder: aDecoder)
        commonInit()
    }
}

private extension MapAndScenesCarouselView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    private func setupViews() {
        mapView.viewModel = MapViewViewModel(scenes: scenes)
        addSubview(mapView)
        
        scenesCarousel = SceneCarouselView(scenes: scenes)
        addSubview(scenesCarousel)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(scenesCarousel.snp.top)
        }

        scenesCarousel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    private func setupObservables() {
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
