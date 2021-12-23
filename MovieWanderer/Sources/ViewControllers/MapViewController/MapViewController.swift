//
//  MapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 10.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

final class MapViewController: BaseCloseViewController {

    private var mapAndScenesView: MapAndScenesCarouselView!
    private let scenes: [Scene]
    private let movieTitle: String

    init(scenes: [Scene], title: String) {
        self.scenes = scenes
        self.movieTitle = title
        super.init(dismissOnPullDown: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

private extension MapViewController {
    
    private func setupViews(){
        mapAndScenesView = MapAndScenesCarouselView(scenes: scenes)
        view.addSubview(mapAndScenesView)
        view.addTopGradient()
        
    }
    
    private func setupConstraints() {
        mapAndScenesView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
        }
    }
    
    private func setupObservables() {
        mapAndScenesView.presentMapsActionSheet$
            .subscribe(onNext: { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        mapAndScenesView.openSceneDetail$
            .subscribe(onNext: { scenes, index in
                self.openSceneDetail(scenes: scenes, index: index)
            })
            .disposed(by: disposeBag)
    }
    
    private func openSceneDetail(scenes: [Scene], index: Int) {
        let sceneDetailViewController = SceneDetailViewController(scenes: scenes, currentIndex: index, title: self.movieTitle, navigationModelController: MapNavigationModelController())
        sceneDetailViewController.modalPresentationStyle = .overFullScreen
        self.present(sceneDetailViewController, animated: true, completion: nil)
    }
}

