//
//  MapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 10.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

final class MapViewController: UIViewController {
    
    var closeButtonTapped$: Observable<()> {
        return closeButton.rx.tap.asObservable()
    }
    
    private var mapAndScenesView: MapAndScenesCarouselView!
    private let closeButton = UIButton(type: .system)
    private let disposeBag = DisposeBag()
    private let places: [Place]

    init(places: [Place]) {
        self.places = places
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupObservables()
    }
}

private extension MapViewController {
    
    private func setupViews(){
        mapAndScenesView = MapAndScenesCarouselView(scenes: places)
        view.addSubview(mapAndScenesView)
        
        if let image = UIImage(named: "close-icon") {
            closeButton.setImage(image, for: .normal)
        }
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        mapAndScenesView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
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

