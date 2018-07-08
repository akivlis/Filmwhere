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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        setView()
        
        let dummyScenes : [Scene] = [Scene(title: "Rocky running", description: "Hahaha", latitude: 48.225660, longitude: 16.399509),
                                Scene(title: "Rocky boxing", description: "Hihihhi", latitude: 49.157614, longitude: 17.075666),
                                Scene(title: "Stairs", description: "Bla bla bla", latitude: -33.865143, longitude: 151.209900),
                                Scene(title: "Rocky talking", description: "Bla bla bla", latitude:  48.157614, longitude: 17.075666)
        ]
        
        let dummyMovies =  [Movie(title: "Rocky", description: "A boxer decides to change his life, so he starts training for the worlds biggest competition in Philadephia. He needs to put all his forces into this fight and so on and on ", scenes: dummyScenes, imageName: "rocky"),
                            Movie(title: "Men in Black", description: "Men are saving the world from the aliens", scenes:dummyScenes, imageName: "placeholder"),
                            
                            Movie(title: "Game Of Thrones", description: "Game of thrones is an american fantasy drama created by Martin.", scenes: dummyScenes, imageName: "Stairs")]
       
        listView.movies = dummyMovies
        
        listView.movieTapped$
            .subscribe(onNext: { [unowned self] movie in
                self.openDetailFor(movie)
            }).disposed(by: disposeBag)
        
    }
}

private extension MovieListViewController {
    
    private func setView() {
        view.addSubview(listView)
        listView.backgroundColor = .white
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.backgroundColor = .white
        title = "Movies"
    }
    
    private func openDetailFor(_ movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
