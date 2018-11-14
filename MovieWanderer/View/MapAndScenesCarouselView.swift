//
//  MapAndScenesCarouselView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 28.08.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

final class MapAndScenesCarouselView: UIView {
    
    private let scenes: [Scene]
    private var scenesCarousel: SceneCarouselView!
    private let mapView = MapView()
    private let disposeBag = DisposeBag()
    private var bottomConstraint : Constraint?
    private let sceneViewHeigh: CGFloat = 200 // TODO: how to calculate this
    private var scenesHidden = false
    
    private let tapOnMap = UITapGestureRecognizer()
    
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
        mapView.addGestureRecognizer(tapOnMap)
        addSubview(mapView)
        
        scenesCarousel = SceneCarouselView(scenes: scenes)
        addSubview(scenesCarousel)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        scenesCarousel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            bottomConstraint = make.bottom.equalTo(mapView).constraint
            make.height.equalTo(sceneViewHeigh)
        }
    }
    
    private func setupObservables() {
        scenesCarousel.scrolledToScene$
            .subscribe(onNext: { [unowned self] scene in
                self.mapView.highlight(scene)
            })
            .disposed(by: disposeBag) // use dispose bag of the cell?
        
        mapView.sceneSelected$
            .subscribe(onNext: { [unowned self] index in
                if self.scenesHidden {
                    self.scenesCarousel.scrollToIndex(index, animated: false)
                    self.showScenes()
                } else {
                    self.scenesCarousel.scrollToIndex(index, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        tapOnMap.rx.event
            .filter { recognizer -> Bool in
                let tapLocation = recognizer.location(in: self.mapView)
                if let subview = self.hitTest(tapLocation, with: nil) {
                    if subview.isKind(of: NSClassFromString("MKAnnotationContainerView")!){
                        print("Tapped out")
                        return true
                    }
                }
                return false
            }
            .map { _ in () }
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.hideScenes()
            })
            .disposed(by: disposeBag)
    }
    
    private func hideScenes() {
        UIView.animate(withDuration: 0.25) {
            self.bottomConstraint?.update(offset: self.sceneViewHeigh)
            self.scenesHidden = true
            self.layoutIfNeeded()
        }
    }
    
    private func showScenes() {
        UIView.animate(withDuration: 0.25) {
            self.bottomConstraint?.update(offset: 0)
            self.scenesHidden = false
            self.layoutIfNeeded()
        }
    }
}
