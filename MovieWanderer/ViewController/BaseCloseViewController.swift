//
//  BaseCloseViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 03.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

// ViewController with close button on the right side

class BaseCloseViewController: UIViewController {

    private let closeButton = UIButton(type: UIButton.ButtonType.system)
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension BaseCloseViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    private func setupViews() {
        if let image = UIImage(named: "close-icon")?.withRenderingMode(.alwaysTemplate) {
            closeButton.setImage(image, for: .normal)
        }
        closeButton.tintColor = .white
        closeButton.imageEdgeInsets =  UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.leading.equalToSuperview().inset(15)
            make.height.width.equalTo(25)
        }
    }
    
    private func setupObservables() {
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
