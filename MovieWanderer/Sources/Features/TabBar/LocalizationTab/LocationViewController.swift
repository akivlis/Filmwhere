//
//  LocationViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class LocationViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let mapView: MapAndScenesCarouselView
    let moviesModelController: MoviesModelController
    
    init(moviesModelController: MoviesModelController) {
        self.moviesModelController = moviesModelController
        self.mapView = MapAndScenesCarouselView(scenes: moviesModelController.allScenes)
        super.init(nibName: nil, bundle: nil)
        
        moviesModelController.moviesUpdated$
            .subscribe(onNext: { [weak self] movies in
                guard let strongSelf = self else { return }
                strongSelf.render()
                print("Scenes in MapView have been updated")
            })
            .disposed(by: disposeBag)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if mapView.scenesHidden {
            mapView.scenesHidden = false
        }
    }
}

private extension LocationViewController {
    
    private func render() {
        mapView.update(scenes: moviesModelController.allScenes)
    }
    
    private func setupViews() {
        view.addSubview(mapView)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupObservables() {
        mapView.openSceneDetail$
            .subscribe(onNext: { scenes, index in
                self.openSceneDetail(scenes: scenes, index: index)
            })
            .disposed(by: disposeBag) // TODO: reload dispose bag when viewController dissaper???
        
        mapView.presentMapsActionSheet$
            .subscribe(onNext: { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func openSceneDetail(scenes: [Scene], index: Int) {
        let sceneDetailViewController = SceneDetailViewController(scenes: scenes, currentIndex: index, title: "All", navigationModelController: MapNavigationModelController())
        sceneDetailViewController.modalPresentationStyle = .overFullScreen
        self.present(sceneDetailViewController, animated: true, completion: nil)
    }
}
