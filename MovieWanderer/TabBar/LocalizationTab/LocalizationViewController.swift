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
    
    var sceneView: SceneListView!
    var mapView: MapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(_view)
        view.backgroundColor = .lightGray
        _view.autoPinEdgesToSuperviewEdges()
        
        
        setupViews()
        
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
    
    func setupViews() {
        
        let scenes : [Scene] = [Scene(title: "Jamie", description: "Hahaha", latitude: 48.225660, longitude: 16.399509),
                                Scene(title: "Lokrum", description: "Hihihhi", latitude: 48.228176, longitude: 16.395046),
                                Scene(title: "Stairs", description: "Bla bla bla", latitude: 48.206959, longitude: 16.390454),
                                Scene(title: "Dany", description: "Bla bla bla", latitude:  48.157614, longitude: 17.075666)]
        
        sceneView = SceneListView(scenes: scenes)
        mapView = MapView(frame: .zero)
        
        _view.containerView.addSubview(sceneView)
        _view.containerView.addSubview(mapView)

        
        sceneView.autoPinEdgesToSuperviewEdges()
        mapView.autoPinEdgesToSuperviewEdges()
        
        mapView.scenes = scenes


    }
    
    func displayViewAt(_ index: Int) {
        
        switch index {
        case 0:
            _view.containerView.bringSubview(toFront: mapView)
        case 1:
            _view.containerView.bringSubview(toFront: sceneView)
        default:
            break
        }
        
    }
    
  
}
