//
//  ModalMapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 10.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

final class ModalMapViewController: UIViewController {
    
    var closeButtonTapped$: Observable<()> {
        return closeButton.rx.tap.asObservable()
    }
    
    private let mapView = MKMapView()
    private let closeButton = UIButton()
    private let disposeBag = DisposeBag()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        
        setupViews()
        setupConstraints()
        setupObservables()
    }
}

private extension ModalMapViewController {
    
    private func setupViews(){
        view.addSubview(mapView)
        
        if let image = UIImage(named: "close-icon") {
            closeButton.setImage(image, for: .normal)
        }
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(15)
            make.height.width.equalTo(25)
        }
    }
    
    private func setupObservables() {
        
        closeButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}
