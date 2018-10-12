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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isNavigationBarHidden = true
        
        setupViews()
        setupContraints()
        setupObservables()
    }
}

private extension MovieDetailViewController {
    
    private func setupViews() {
        title = movie.title
        view.backgroundColor = .white
        view.addSubview(verticalScenesView)
        
        backButton.setImage(UIImage(named: "back-icon"), for: .normal)
        view.addSubview(backButton)
        
        scenesTitleLabel.textColor = .black
        scenesTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        scenesTitleLabel.text = "Scenes"
        scenesTitleLabel.textAlignment = .left
        
        numberOfPlacesLabel.textColor = .gray
        numberOfPlacesLabel.textAlignment = .right
        numberOfPlacesLabel.font = UIFont.systemFont(ofSize: 16)
        numberOfPlacesLabel.text = "\(self.movie.scenes.count) places" // TODO: move to viewModel?
//        view.addSubview(numberOfPlacesLabel)
        
//        scrollView.addSubview(scenesTitleLabel)
    }
    
    private func setupContraints() {
        verticalScenesView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(20)
        }
    }
    
    private func setupObservables() {
        
//        movieHeaderView.goToMap$
//            .subscribe(onNext: { [unowned self] _ in
//                let modalViewController = MapViewController(places: self.movie.scenes)
//                self.present(modalViewController, animated: true, completion: nil)
//            }).disposed(by: disposeBag)
        
        //TODO: scenestableView should be private, expose only click
        verticalScenesView.scenesCollectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self]_ in
                let sceneDetailViewController = SceneDetailViewController()
                self.present(sceneDetailViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}




