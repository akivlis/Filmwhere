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
    
    private var _openSceneDetail$ = PublishSubject<([Scene], Int)>()
    var openSceneDetail$: Observable<([Scene], Int)>{
        return _openSceneDetail$
    }
    
    let presentMapsActionSheet$: Observable<UIAlertController>
    
    var scenesHidden = false {
        didSet {
            if scenesHidden {
                hideScenes()
            } else {
                showScenes()
            }
        }
    }
    
    private var scenes: [Scene]
    private let scenesCarousel: SceneCarouselView
    private let mapView : MapView
    private let disposeBag = DisposeBag()
    private var bottomConstraint : Constraint?
    private let sceneViewHeigh = Constants.ScenesCollection.height
    private let tapOnMap = UITapGestureRecognizer()
    
    init(scenes: [Scene]) {
        self.scenes = scenes
        self.mapView = MapView(viewModel: MapViewViewModel(scenes: scenes),
                               navigationModelController: MapNavigationModelController())
        scenesCarousel = SceneCarouselView(scenes: scenes)
        presentMapsActionSheet$ = mapView.presentMapsActionSheet$
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Public
    
    func update(scenes: [Scene]) {
        self.scenes = scenes
        mapView.viewModel = MapViewViewModel(scenes: scenes)
        scenesCarousel.setScenes(scenes: scenes)
    }
    
    func update(movie: Movie) {
        self.scenes = movie.scenes
        mapView.viewModel = MapViewViewModel(scenes: movie.scenes)
        scenesCarousel.setScenes(scenes: movie.scenes)
    }
}

private extension MapAndScenesCarouselView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    private func setupViews() {
        mapView.addGestureRecognizer(tapOnMap)
        addSubview(mapView)
        
        addSubview(scenesCarousel)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        scenesCarousel.snp.makeConstraints { make in
            bottomConstraint = make.bottom.equalTo(mapView).constraint
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(sceneViewHeigh)
        }
    }
    
    private func setupObservables() {
        scenesCarousel.scrolledToScene$
            .subscribe(onNext: { [weak self] scene in
                self?.mapView.highlight(scene)
            })
            .disposed(by: disposeBag) // use dispose bag of the cell?
        
        scenesCarousel.selectSceneCell$
            .subscribe(onNext: { [weak self] index in
                guard let strongSelf = self else { return }
                strongSelf._openSceneDetail$.onNext((strongSelf.scenes, index))
            })
            .disposed(by: disposeBag) // use dispose bag of the cell?
        
        mapView.sceneSelected$
            .subscribe(onNext: { [unowned self] index in
                if self.scenesHidden {
                    self.scenesCarousel.scrollToIndex(index, animated: false)
                    self.scenesHidden = false
                } else {
                    self.scenesCarousel.scrollToIndex(index, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        tapOnMap.rx.event
            .filter { recognizer -> Bool in
                let tapLocation = recognizer.location(in: self.mapView)
                if let subview = self.hitTest(tapLocation, with: nil) {
                    //TODO: check this for clusterView
                    if subview.isKind(of: NSClassFromString("MKAnnotationContainerView")!){
                        return true
                    }
                }
                return false
            }
            .map { _ in () }
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.scenesHidden = true
            })
            .disposed(by: disposeBag)
    }
    
    private func hideScenes() {
        UIView.animate(withDuration: 0.25) {
            self.bottomConstraint?.update(offset: self.sceneViewHeigh)
            self.layoutIfNeeded()
        }
    }
    
    private func showScenes() {
        UIView.animate(withDuration: 0.25) {
            self.bottomConstraint?.update(offset: 0)
            self.layoutIfNeeded()
        }
    }
}
