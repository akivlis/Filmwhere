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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        let dummyScenes : [Place] = [Place(title: "Rocky", description: "Hahaha", latitude:39.962920, longitude: -75.157235),
                                Place(title: "Stairs", description: "Dubrovnik", latitude: 42.645942, longitude: 18.090084),
                                Place(title: "Mission Impossible", description: "Vienn Opera", latitude:  48.202840, longitude: 16.368916),
                                Place(title: "Red Sparrow", description: "Hofburg", latitude:  48.208347, longitude: 16.366143),
                                Place(title: "Roman holiday", description: "Spanish stairs", latitude:  41.899355, longitude: 12.484746)

        ]
        
        let dummyMovies =  [Movie(title: "Rocky", description: "A boxer decides to change his life, so he starts training for the worlds biggest competition in Philadephia. He needs to put all his forces into this fight and so on and on ", places: dummyScenes, imageName: "Rocky"),
                            Movie(title: "Men in Black", description: "Men are saving the world from the aliens", places:dummyScenes, imageName: "placeholder"),
                            
                            Movie(title: "Game Of Thrones", description: "Game of thrones is an american fantasy drama created by Martin.", places: dummyScenes, imageName: "Stairs")]
       
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
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
