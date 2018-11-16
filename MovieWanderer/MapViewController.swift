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
    
    private let topGradient : GradientView = {
        let gradient = GradientView()
        gradient.colors = (UIColor.black.withAlphaComponent(0.5), .clear)
        return gradient
    }()
    
    private var mapAndScenesView: MapAndScenesCarouselView!
    private let closeButton = UIButton(type: .system)
    private let disposeBag = DisposeBag()
    private let scenes: [Scene]
    private let movieTitle: String

    init(scenes: [Scene], title: String) {
        self.scenes = scenes
        self.movieTitle = title
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

private extension MapViewController {
    
    private func setupViews(){
        mapAndScenesView = MapAndScenesCarouselView(scenes: scenes, title: movieTitle)
        view.addSubview(mapAndScenesView)
        
        view.addSubview(topGradient)
        
        if let image = UIImage(named: "close-icon")?.withRenderingMode(.alwaysTemplate) {
            closeButton.setImage(image, for: .normal)
        }
        closeButton.imageEdgeInsets =  UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        closeButton.tintColor = .white
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        mapAndScenesView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.leading.equalToSuperview().inset(15)
            make.height.width.equalTo(25)
        }
        
        topGradient.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func setupObservables() {
        closeButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}

