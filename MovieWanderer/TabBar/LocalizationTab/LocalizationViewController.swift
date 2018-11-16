//
//  SceneListViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class LocalizationViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var mapView: MapAndScenesCarouselView!
    
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

private extension LocalizationViewController {
    
    private func setupViews() {
        let scenes : [Scene] = [Scene(title: "Jamie", description: "Hahaha", latitude: 48.225660, longitude: 16.399509),
                                Scene(title: "Lokrum", description: "Hihihhi", latitude: 48.228176, longitude: 16.395046),
                                Scene(title: "Stairs", description: "Bla bla bla", latitude: 48.206959, longitude: 16.390454),
                                Scene(title: "Dany", description: "Bla bla bla", latitude:  48.157614, longitude: 17.075666)]
        
        let movie = Movie(title: "Game Of Thrones", description: "", scenes: scenes, imageUrl: "")
        mapView = MapAndScenesCarouselView(scenes: scenes, title: movie.title)
        
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
            }).disposed(by: disposeBag) // TODO: reload dispose bag when viewController dissaper???
    }
    
    private func openSceneDetail(scenes: [Scene], index: Int) {
        let sceneDetailViewController = SceneDetailViewController(scenes: scenes, currentIndex: index, title: "All")
        sceneDetailViewController.modalPresentationStyle = .overFullScreen
        self.present(sceneDetailViewController, animated: true, completion: nil)
    }
}
