//
//  SceneListViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import PureLayout
import RxSwift
import RxCocoa


class LocalizationViewController: UIViewController {
    
   let _view = LocalizationView()
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(_view)
        view.backgroundColor = .lightGray
        _view.autoPinEdgesToSuperviewEdges()
        
        _view.switchControlValueChanged$
            .subscribe(onNext: { [unowned self] index in
                self.displayViewAt(index)
            }).disposed(by: disposeBag)
    }
    
}

fileprivate extension LocalizationViewController {
    
    func displayViewAt(_ index: Int) {

        _view.containerView.subviews.forEach { $0.removeFromSuperview() }
        
        if index == 1 {
            
            let scenes : [Scene] = [Scene(title: "Walk of shame", description: "Bla bla bla", position: "fsfs"),
                                    Scene(title: "Red wedding", description: "Stark family got killed", position: "fsfjsk"),
                                    Scene(title: "On the Wall", description: "John snow knows nothing", position: "fnsjfns"),
                                    Scene(title: "HAHAHA", description: "John snow knows nothing", position: "fnsjfns")]
            
            let sceneView = SceneListView(scenes: scenes)
            
            _view.containerView.insertSubview(sceneView, at: 0)
            sceneView.autoPinEdgesToSuperviewEdges()


        } else {
            
            let mapView = MapView(frame: .zero)
        
            _view.containerView.insertSubview(mapView, at: 0)
            mapView.autoPinEdgesToSuperviewEdges()
        }
    }
    
  
}
