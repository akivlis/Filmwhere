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
    }
}

private extension LocalizationViewController {
    
    private func setupViews() {
      
        let scenes : [Scene] = [Scene(title: "Jamie", description: "Hahaha", latitude: 48.225660, longitude: 16.399509),
                                Scene(title: "Lokrum", description: "Hihihhi", latitude: 48.228176, longitude: 16.395046),
                                Scene(title: "Stairs", description: "Bla bla bla", latitude: 48.206959, longitude: 16.390454),
                                Scene(title: "Dany", description: "Bla bla bla", latitude:  48.157614, longitude: 17.075666)]
        
        let movie = Movie(title: "", description: "", scenes: scenes, imageUrl: "")
        mapView = MapAndScenesCarouselView(scenes: scenes)
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
