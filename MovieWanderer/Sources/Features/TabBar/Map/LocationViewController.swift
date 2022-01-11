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
import Combine

class LocationViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let mapView: MapAndScenesCarouselView
    private let viewModel: LocationViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
        self.mapView = MapAndScenesCarouselView(scenes: viewModel.scenes)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if mapView.scenesHidden {
            mapView.scenesHidden = false
        }

        viewModel.loadAllScenes()
    }
}

private extension LocationViewController {
    
    private func render(_ scenes: [Scene]) {
        mapView.update(scenes: scenes)
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
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { scenes, index in
                self.openSceneDetail(scenes: scenes, index: index)
            })
            .disposed(by: disposeBag) // TODO: reload dispose bag when viewController dissaper???
        
        mapView.presentMapsActionSheet$
            .subscribe(onNext: { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        viewModel.scenesPublisher
            .sink { [weak self ] scenes in
                guard let self = self else { return }
                self.render(scenes)
                print("Scenes in MapView have been updated")
            }
            .store(in: &subscriptions)
    }
    
    private func openSceneDetail(scenes: [Scene], index: Int) {
        let sceneDetailViewController = SceneDetailViewController(scenes: scenes, currentIndex: index, title: "All", navigationModelController: MapNavigationModelController())
        sceneDetailViewController.modalPresentationStyle = .fullScreen
        self.present(sceneDetailViewController, animated: true, completion: nil)
    }
}
