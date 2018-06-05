//
//  MovieDetailViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

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

fileprivate extension MovieDetailViewController {
    
    func loadSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(movieDetailView)
    }
    
    func setContraints() {
        
//        let padding: CGFloat = 12

        scrollView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        scrollView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        scrollView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        scrollView.autoPinToSafeArea(.bottom, of: self, withInset: 0, insetForDeviceWithNotch: 0)
        
        movieDetailView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        movieDetailView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        movieDetailView.autoPinEdge(toSuperviewEdge: .left)
        movieDetailView.autoPinEdge(toSuperviewEdge: .right)

        movieDetailView.autoMatch(.width, to: .width, of: scrollView)
    }

}
