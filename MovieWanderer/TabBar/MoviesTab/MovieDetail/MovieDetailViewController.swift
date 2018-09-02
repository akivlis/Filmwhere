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
    private let scenesCarouselView : VerticalScenesView
    private let disposeBag = DisposeBag()
    private let movie: Movie
    private let scenesTitleLabel = UILabel()
    private let backButton = UIButton()
    private let numberOfPlacesLabel = UILabel()

    // MARK: Init
    
    init(movie: Movie) {
        self.movie = movie
        movieHeaderView = MovieHeaderView(viewModel: MovieHeaderViewModel(movie: movie))
        scenesCarouselView = VerticalScenesView(scenes: movie.scenes)
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

        scrollView.delegate = self
        setupViews()
        setupContraints()
        setupObservables()
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
        view.addSubview(numberOfPlacesLabel)
        
        scrollView.addSubview(movieHeaderView)
        scrollView.addSubview(scenesTitleLabel)
        scrollView.addSubview(scenesCarouselView)
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
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(20)
        }
        
        scenesTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview()
            make.top.equalTo(movieHeaderView.snp.bottom).offset(5)
        }
        
        numberOfPlacesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scenesTitleLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        scenesCarouselView.snp.makeConstraints { make in
            make.top.equalTo(scenesTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide) //TODO: dat vysku ako je vleke table view??
        }
    }
    
    private func setupObservables() {
        
        movieHeaderView.goToMap$
            .subscribe(onNext: { [unowned self] _ in
                let modalViewController = MapViewController(viewModel: MapViewModel(scenes: self.movie.scenes))
                self.present(modalViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        //TODO: scenestableView should be private, expose only click
        scenesCarouselView.scenesTableView.rx.itemSelected
            .subscribe(onNext: { [unowned self]_ in
                let modalViewController = MapViewController(viewModel: MapViewModel(scenes: self.movie.scenes))
                self.present(modalViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}




