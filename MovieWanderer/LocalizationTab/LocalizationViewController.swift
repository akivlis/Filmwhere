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
        view.backgroundColor = .white
        _view.autoPinEdgesToSuperviewEdges()
        
        _view.switchControlValueChanged$
            .subscribe(onNext: { [unowned self] index in
                self.displayControllerAt(index)
            }).disposed(by: disposeBag)
    }
    
}

fileprivate extension LocalizationViewController {
    
    func displayControllerAt(_ index: Int) {
        
       let sceneViewController = ScenesViewController()
        let mapViewController = MapViewController()
        let viewControllers: [UIViewController] = [mapViewController, sceneViewController]
        
        
        _view.containerView.subviews.forEach { $0.removeFromSuperview() }
        _view.containerView.insertSubview(viewControllers[index].view, at: 0)
    }
    
  
}
