//
//  MapViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 10.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

final class MapViewController: BaseCloseViewController {

    private let topGradient : GradientView = {
        let gradient = GradientView()
        gradient.colors = (UIColor.black.withAlphaComponent(0.5), .clear)
        return gradient
    }()
    
    private var mapAndScenesView: MapAndScenesCarouselView!
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
    }
    
    private func setupConstraints() {
        mapAndScenesView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
        }

        topGradient.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(80)
        }
        
        mapAndScenesView.presentMapsActionSheet$
            .subscribe(onNext: { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupObservables() {

    }
}

