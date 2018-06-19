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
        control.selectedSegmentIndex = 0
        return control
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addUIComponents()
        setContraints()
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIComponents() {
        addSubview(containerView)
        addSubview(viewSwitchControl)
    }
    
    func setContraints() {
        viewSwitchControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(35)
            make.width.equalTo(120)
        }

        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(viewSwitchControl.snp.bottom).offset(12)
        }
    }    
}
