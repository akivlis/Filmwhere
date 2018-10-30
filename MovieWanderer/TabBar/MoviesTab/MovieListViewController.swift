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
    
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        let dummyScenes : [Scene] = [Scene(title: "Rocky", description: "Hahaha", latitude:39.962920, longitude: -75.157235),
                                Scene(title: "Stairs", description: "Dubrovnik", latitude: 42.645942, longitude: 18.090084),
                                Scene(title: "Mission Impossible", description: "Vienn Opera", latitude:  48.202840, longitude: 16.368916),
                                Scene(title: "Red Sparrow", description: "Hofburg", latitude:  48.208347, longitude: 16.366143),
                                Scene(title: "Roman holiday", description: "Spanish stairs", latitude:  41.899355, longitude: 12.484746)

        ]
        
        let dummyMovies =  [Movie(title: "Rocky", description: "A boxer decides to change his life, so he starts training for the worlds biggest competition in Philadephia. He needs to put all his forces into this fight and so on and on ", scenes: dummyScenes, imageName: "Rocky"),
                            Movie(title: "Men in Black", description: "Men are saving the world from the aliens", scenes:dummyScenes, imageName: "placeholder"),
                            
                            Movie(title: "Game Of Thrones", description: "Game of thrones is an american fantasy drama created by Martin.", scenes: dummyScenes, imageName: "Stairs")]
       
        listView.movies = dummyMovies
        
        listView.movieTapped$
            .subscribe(onNext: { [unowned self] movie in
                self.openDetailFor(movie)
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}

private extension MovieListViewController {
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        view.backgroundColor = .white
        title = "Movies"
        view.addSubview(listView)
        listView.backgroundColor = .white
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = kCATransitionMoveIn
//        transition.subtype = kCATransitionFromRight
//        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
////        self.view.window
//        self.view.window!.layer.add(transition, forKey: nil)
//        present(movieDetailViewController, animated: true, completion: nil)
//        navigationController?.present(movieDetailViewController, animated: false, completion: nil)
//        navigationController?.present(movieDetailViewController, animated: true, completion: nil)
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
