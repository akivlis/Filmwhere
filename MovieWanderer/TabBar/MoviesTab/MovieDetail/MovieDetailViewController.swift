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
    private let movieDetailView : MovieDetailStackView
    private let disposeBag = DisposeBag()
    
    // MARK: Init
    
    init(movie: Movie) {
        
        movieDetailView = MovieDetailStackView(viewModel: MovieDetailViewModel(movie: movie))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSubviews()
        setContraints()
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        
        view.backgroundColor = .gray
    }

}

private extension MovieDetailViewController {
    
    func loadSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(movieDetailView)
    }
    
    func setContraints() {
        
        scrollView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        movieDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
      
//        movieDetailView.autoMatch(.width, to: .width, of: scrollView)
    }

}
