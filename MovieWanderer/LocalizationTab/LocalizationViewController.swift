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
    
    
    fileprivate let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .yellow
        return containerView
    }()
    
    fileprivate let viewSwitchControl: UISegmentedControl = {
        let items = ["Map", "List"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 1
        return control
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addUIComponents()
        setContraints()
        
        viewSwitchControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [unowned self] index in
                self.displayControllerAt(index)
            })
        
//        //check openMimoWeb
//        continueButton.rx.tap
//            //                .flatMap {
//            //                    viewModel.login()
//            //                }
//            .subscribe(onNext: { [unowned self] _ in
//                //TODO: open app
//                print("continue button tapped")
//                self.present(TabBarViewController(), animated: false, completion: nil)
//                //TODO: set tabbar as new rootviewcontroller to remove the login from memory
//
//            }).disposed(by: disposeBag)
        
     
        
    }
    
}

fileprivate extension LocalizationViewController {
    
    func addUIComponents() {
        view.addSubview(containerView)
        view.addSubview(viewSwitchControl)
    }
    
    func setContraints() {
        viewSwitchControl.autoAlignAxis(toSuperviewAxis: .vertical)
        viewSwitchControl.autoPinEdge(toSuperviewEdge: .top, withInset: 35)
        viewSwitchControl.autoSetDimension(.width, toSize: 120)
        
        containerView.autoPinEdge(toSuperviewEdge: .left)
        containerView.autoPinEdge(toSuperviewEdge: .right)
        containerView.autoPinEdge(toSuperviewEdge: .bottom)
        containerView.autoPinEdge(.top, to: .bottom, of: viewSwitchControl, withOffset: 12)
        
    }
    
    func displayControllerAt(_ index: Int) {
        
       let sceneViewController = ScenesViewController()
        let mapViewController = MapViewController()
        let viewControllers: [UIViewController] = [sceneViewController, mapViewController]
        
        
        containerView.subviews.forEach { $0.removeFromSuperview() }
        self.containerView.insertSubview(viewControllers[index].view, at: 0)
    }
    
  
}
