//
//  MovieListViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

class MovieListViewController: UIViewController {

    private let listView = MovieListView()
    private let disposeBag = DisposeBag()
    
    private let moviesModelController : MoviesModelController
    
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    init(moviesModelController: MoviesModelController) {
        self.moviesModelController = moviesModelController
        super.init(nibName: nil, bundle: nil)
        
        self.moviesModelController.moviesUpdated$
            .subscribe(onNext: { [weak self] movies in
                self?.stopRefreshing()
                self?.listView.movies = movies
            })
            .disposed(by: disposeBag)
        
        self.moviesModelController.showAlert$
            .subscribe(onNext: { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
                self?.stopRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupObservables()
        
        listView.refreshControl.addTarget(self, action: #selector(refreshMovieData), for: .valueChanged)
    }
    
   
}

private extension MovieListViewController {
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        title = "Movies"
        view.addSubview(listView)
        listView.backgroundColor = .white
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupObservables() {
        listView.movieTapped$
            .subscribe(onNext: { [weak self] movie in
                self?.openDetailFor(movie)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func openDetailFor(_ movie: Movie) {
        let viewModel = MovieDetailViewModel(movie: movie)
        let movieDetailViewController = MovieDetailViewController(viewModel: viewModel)
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()
        
        movieDetailViewController.modalPresentationStyle = .custom
        movieDetailViewController.transitioningDelegate = self
        movieDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        
        present(movieDetailViewController, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
    
    @objc private func refreshMovieData() {
        self.moviesModelController.loadMovies()
    }
    
    private func stopRefreshing() {
        self.listView.refreshControl.endRefreshing()
//        self.activityIndicatorView.stopAnimating()
    }
}

extension MovieListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
