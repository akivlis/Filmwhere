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

    private let scrollView = UIScrollView()
    private let movieHeaderView : MovieHeaderView
    private let scenesCarouselView : SceneCarouselView
    private let disposeBag = DisposeBag()
    private let movie: Movie
    private let scenesTitleLabel = UILabel()
    private let mapView = MapView()
    private var gradient = CAGradientLayer()

    // MARK: Init
    
    init(movie: Movie) {
        self.movie = movie
        movieHeaderView = MovieHeaderView(viewModel: MovieHeaderViewModel(movie: movie))
        scenesCarouselView = SceneCarouselView(scenes: movie.scenes)
        scenesCarouselView.cellSize = CGSize(width: 140, height: 230)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradient.frame = mapView.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        scrollView.delegate = self
        setupViews()
        setupContraints()
        setupObservables()
        
        mapView.scenes = movie.scenes
        mapView.moveCameraToScene(scene: movie.scenes[0])
        mapView.highlightMarker(for: 3)
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        movieHeaderView.updatePosition(withInset: scrollView.contentInset.top, contentOffset: scrollView.contentOffset.y)
    }
}

private extension MovieDetailViewController {
    
    private func setupViews() {
        title = movie.title
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scenesTitleLabel.textColor = .black
        scenesTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        scenesTitleLabel.text = "Scenes"
        scenesTitleLabel.textAlignment = .left
        
        scrollView.addSubview(movieHeaderView)
        scrollView.addSubview(scenesTitleLabel)
        scrollView.addSubview(scenesCarouselView)
        scrollView.addSubview(mapView)
        
        gradient.frame = mapView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.1, 0.9, 1]
        mapView.layer.mask = gradient
    }
    
    private func setupContraints() {
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
  
        movieHeaderView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
        
        scenesTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview()
            make.top.equalTo(movieHeaderView.snp.bottom).offset(16)
        }
        
        scenesCarouselView.snp.makeConstraints { make in
            make.top.equalTo(scenesTitleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(scenesCarouselView.cellSize!.height)
        }
        
        mapView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scenesCarouselView.snp.bottom).offset(4)
            make.height.equalTo(300)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupObservables() {
        
        movieHeaderView.goToMap$
            .subscribe(onNext: { [unowned self] _ in
                let modalViewController = ModalMapViewController()
                modalViewController.scenes = self.movie.scenes
                self.present(modalViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        scenesCarouselView.scenesCollectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self]_ in
                let modalViewController = ModalMapViewController()
                modalViewController.scenes = self.movie.scenes
                self.present(modalViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)

    }
}




