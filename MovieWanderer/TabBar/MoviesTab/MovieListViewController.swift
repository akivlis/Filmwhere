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

    private let listView = MovieListView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
        }
        
        setView()
        
        let dummyMovies =  [Movie(title: "Rocky", description: "fslfhslfhslfhsl", scenes: [Scene](), imageName: "rocky"),
                            Movie(title: "Men in Black", description: "fsfsfs", scenes: [Scene](), imageName: "placeholder"),
                            
                            Movie(title: "Game of thrones", description: "Game of thrones is an american fantasy drama created by.. Its an adaption of Song of ICe and Fire from fantasy series, of which Game of thrones is the first one bla bla bla bla bla", scenes: [Scene](), imageName: "placeholder")]
       
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
        listView.autoPinEdgesToSuperviewEdges()
        
        listView.backgroundColor = .white
        
        title = "Movies"
//        navigationController?.navigationBar.barTintColor = .gray

    }
    
    private func openDetailFor(_ movie: Movie) {
        
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        
//        navigationController?.present(movieDetailViewController, animated: true, completion: nil)
    }
}
