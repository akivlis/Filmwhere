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
    
    // Set the status bar style to complement night-mode.
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
}

fileprivate extension LocalizationViewController {
    
    func displayViewAt(_ index: Int) {
        
        let scenes : [Scene] = [Scene(title: "Home", description: "Hahaha", latitude: 48.225660, longitude: 16.399509),
                                Scene(title: "Agi", description: "Hihihhi", latitude: 48.228176, longitude: 16.395046),
                                Scene(title: "Mimo", description: "Bla bla bla", latitude: 48.206959, longitude: 16.390454),
                                Scene(title: "ZOO", description: "Bla bla bla", latitude:  48.157614, longitude: 17.075666)]
        

        _view.containerView.subviews.forEach { $0.removeFromSuperview() }
        
        if index == 1 {
           
            let sceneView = SceneListView(scenes: scenes)
            
            _view.containerView.insertSubview(sceneView, at: 0)
            sceneView.autoPinEdgesToSuperviewEdges()


        } else {
            
            let mapView = MapView(frame: .zero)
        
            _view.containerView.insertSubview(mapView, at: 0)
            mapView.autoPinEdgesToSuperviewEdges()
            
            mapView.scenes = scenes
        }
    }
    
  
}
