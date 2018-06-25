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
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
        }
        
        setView()
        
        let dummyScenes = [Scene(title: "Rocky running", description: "Rocky running up the stars in Philadephia", latitude: 33.0, longitude: 34.00),
                           Scene(title: "Rocky boxing", description: "Rocky running up the stars in Philadephia", latitude: 33.0, longitude: 34.00),
                           Scene(title: "Rocky talking", description: "Rocky running up the stars in Philadephia", latitude: 33.0, longitude: 34.00) ]
        
        let dummyMovies =  [Movie(title: "Rocky", description: "A boxer decides to change his life", scenes: dummyScenes, imageName: "rocky"),
                            Movie(title: "Men in Black", description: "Men are saving the world from the aliens", scenes:dummyScenes, imageName: "placeholder"),
                            
                            Movie(title: "Game of thrones", description: "Game of thrones is an american fantasy drama created by Martin.", scenes: dummyScenes, imageName: "Stairs")]
       
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
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listView.backgroundColor = .white
        
        title = "Movies"
    }
    
    private func openDetailFor(_ movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
