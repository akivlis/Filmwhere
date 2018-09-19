//
//  SceneDetailViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 19.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

final class SceneDetailViewController: UIViewController {
    
    
    private let disposeBag = DisposeBag()
    private let closeButton = UIButton(type: UIButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        
        closeButton.rx.tap.subscribe(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}

private extension SceneDetailViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .myRed

        if let image = UIImage(named: "close-icon") {
            closeButton.setImage(image, for: .normal)
        }
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.height.width.equalTo(25)
        }
    }
}
