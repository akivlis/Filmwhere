//
//  MovieListViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import PureLayout
import RxSwift



class MovieListViewController: UIViewController {

    fileprivate let listView = MovieListView()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
        let dummyMovies = [Movie(title: "Men in Black", description: "fslfhslfhslfhsl", scenes: [Scene]()),
                           Movie(title: "Game of thrones", description: "fslfhslfhslfhsl", scenes: [Scene]()),
                           Movie(title: "Rocky", description: "fslfhslfhslfhsl", scenes: [Scene]())]
        listView.movies = dummyMovies
        
        
        listView.movieTapped$
            .subscribe(onNext: { [unowned self] movie in
                self.openDetailFor(movie)
            }).disposed(by: disposeBag)
        
    }
    
    
    

}

fileprivate extension MovieListViewController {
    
    func setView() {
        
        view.addSubview(listView)
        listView.autoPinEdgesToSuperviewEdges()
        
        listView.backgroundColor = .white
        
        title = "Movies"
        navigationController?.navigationBar.barTintColor = .gray

    }
    
    func openDetailFor(_ movie: Movie) {
        
        let movieDetailViewController = MovieDetailViewController()
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        
//        navigationController?.present(movieDetailViewController, animated: true, completion: nil)
    }
}
