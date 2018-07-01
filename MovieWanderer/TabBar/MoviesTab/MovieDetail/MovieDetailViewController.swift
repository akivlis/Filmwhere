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
    
    // MARK: Init
    
    init(movie: Movie) {
        self.movie = movie
        movieHeaderView = MovieHeaderView(viewModel: MovieHeaderViewModel(movie: movie))
        scenesCarouselView = SceneCarouselView(scenes: movie.scenes)
        scenesCarouselView.cellSize = CGSize(width: 150, height: 200)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .never
        }
        
        view.backgroundColor = .red

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear

        scrollView.delegate = self
        setupViews()
        setupContraints()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        guard self.navigationController?.topViewController === self else { return }
//        self.transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
//            self?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//            self?.navigationController?.navigationBar.shadowImage = UIImage()
//            self?.navigationController?.navigationBar.backgroundColor = .clear
//            self?.navigationController?.navigationBar.barTintColor = .clear
//            }, completion: nil)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        self.transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
//            self?.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
//            self?.navigationController?.navigationBar.shadowImage = nil
//            self?.navigationController?.navigationBar.backgroundColor = .white
//            self?.navigationController?.navigationBar.barTintColor = .white
//            }, completion: nil)
//    }
    
}

private extension MovieDetailViewController {
    
    private func setupViews() {
        
        title = movie.title
        view.backgroundColor = .white

//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.bounces = false
        
//        edgesForExtendedLayout = [.top, .bottom]
//        extendedLayoutIncludesOpaqueBars = true
        
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        
        scenesTitleLabel.textColor = .black
        scenesTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        scenesTitleLabel.text = "Scenes"
        scenesTitleLabel.textAlignment = .left
        
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
        
        scenesTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview()
            make.top.equalTo(movieHeaderView.snp.bottom).offset(16)
        }
        
        scenesCarouselView.snp.makeConstraints { make in
            make.top.equalTo(scenesTitleLabel.snp.bottom).offset(200) //remove offset
            make.left.right.equalToSuperview()
            make.height.equalTo(220) // check this
            make.bottom.equalToSuperview()
        }
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        movieHeaderView.updatePosition(withInset: scrollView.contentInset.top, contentOffset: scrollView.contentOffset.y)
    }
}


