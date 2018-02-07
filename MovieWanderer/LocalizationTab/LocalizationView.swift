//
//  LocalizationView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 07/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class LocalizationView : UIView {
    
    
//    var settingsButtonTapped$: Observable<()> {
//        return settingsButton.rx.tap.asObservable()
//            .throttle(2, scheduler: MainScheduler.instance)
//    }
//
//    var openDeveloperMenu$: Observable<()> {
//        return tap.rx.event.map { _ in () }.asObservable()
//            .skip(6)
//    }
    
    var switchControlValueChanged$: Observable<(Int)> {
        return viewSwitchControl.rx.selectedSegmentIndex.asObservable()
    }

    
    let containerView: UIView = {
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUIComponents()
        setContraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIComponents() {
        addSubview(containerView)
        addSubview(viewSwitchControl)
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
    
}
