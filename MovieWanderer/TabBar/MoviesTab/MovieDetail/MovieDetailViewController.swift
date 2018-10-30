//
//  MovieDetailViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class MovieDetailViewController: UIViewController {

    private let verticalScenesView : VerticalScenesView
    private let disposeBag = DisposeBag()
    private let movie: Movie
    private let scenesTitleLabel = UILabel()
    private let backButton = UIButton()
    private let numberOfPlacesLabel = UILabel()
    private let animatingBarView = AnimatingBarView()

    // MARK: Init
    
    init(movie: Movie) {
        self.movie = movie
        verticalScenesView = VerticalScenesView(movie: movie)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        setupObservables()
    }
}

private extension MovieDetailViewController {
    
    private func setupViews() {
        title = self.movie.title
        view.backgroundColor = .white
        
        view.addSubview(verticalScenesView)
        view.addSubview(animatingBarView)
        
        backButton.setImage(UIImage(named: "back-icon"), for: .normal)
        backButton.imageEdgeInsets =  UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        view.addSubview(backButton)
    }
    
    private func setupContraints() {
        verticalScenesView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        animatingBarView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(64)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.centerY.equalTo(animatingBarView).offset(10)
            make.height.width.equalTo(25)
        }
    }
    
    private func setupObservables() {
        verticalScenesView.showMapTapped$
            .subscribe(onNext: { [unowned self] _ in
                let modalViewController = MapViewController(places: self.movie.scenes)
                self.present(modalViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        //TODO: scenestableView should be private, expose only click
        verticalScenesView.scenesCollectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] index in
                let sceneDetailViewController = SceneDetailViewController(scenes: self.movie.scenes, currentIndex: index.row)
                sceneDetailViewController.modalPresentationStyle = .overFullScreen
                self.present(sceneDetailViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        verticalScenesView.scenesCollectionView.rx.didScroll
            .subscribe(onNext: { _ in
                
                //todo: probably calculate this number (120) based on image height
                if self.verticalScenesView.scenesCollectionView.contentOffset.y > 120 {
                    let offset = self.verticalScenesView.scenesCollectionView.contentOffset.y / 80 //check this number
                    let number = offset - 1
                        self.animateNavigationBar(offset: number)
                } else {
                    self.animateNavigationBar(offset: 0.0)
                }
            }).disposed(by: disposeBag)
    }
    
    private func animateNavigationBar(offset: CGFloat) {
        animatingBarView.setColorWith(alpha: offset)
    }
}



