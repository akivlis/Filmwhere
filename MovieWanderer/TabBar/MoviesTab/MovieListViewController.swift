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
    private let viewModel = MovieListViewModel()
    
    
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupObservables()
        
        viewModel.loadMovies()
    }
}

private extension MovieListViewController {
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        view.backgroundColor = .blue
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
        
        viewModel.displayMovies$
            .subscribe(onNext: { [weak self] movies in
                self?.listView.movies = movies
            })
            .disposed(by: disposeBag)
        
        viewModel.showAlert$
            .subscribe(onNext: { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func openDetailFor(_ movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        
            presentTransition = RightToLeftTransition()
            dismissTransition = LeftToRightTransition()
            
            movieDetailViewController.modalPresentationStyle = .custom
            movieDetailViewController.transitioningDelegate = self
            
            present(movieDetailViewController, animated: true, completion: { [weak self] in
                self?.presentTransition = nil
            })
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
