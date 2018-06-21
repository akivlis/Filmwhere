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
    
    // MARK: Init
    
    init(movie: Movie) {
        self.movie = movie
        movieHeaderView = MovieHeaderView(viewModel: MovieHeaderViewModel(movie: movie))
        scenesCarouselView = SceneCarouselView(scenes: movie.scenes)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
    }
}

private extension MovieDetailViewController {
    
    private func setupViews() {
        
        title = movie.title
        view.backgroundColor = .gray

        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.backgroundColor = .red
        view.addSubview(scrollView)
        
        scrollView.addSubview(movieHeaderView)
        scrollView.addSubview(scenesCarouselView)
    }
    
    private func setupContraints() {
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        movieHeaderView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scenesCarouselView.snp.makeConstraints { make in
            make.top.equalTo(movieHeaderView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
    }

}
