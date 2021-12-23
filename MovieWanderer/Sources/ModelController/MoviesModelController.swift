//
//  MoviesModelController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 27.11.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class MoviesModelController {
    
    var moviesUpdated$: Observable<[Movie]> {
        return _displayMovies$
    }
    
    var showAlert$: Observable<UIAlertController> {
        return _showAlert$
    }
    
    var allScenes: [Scene] {
        return movies.flatMap { $0.scenes }
    }
    
    private var movies: [Movie] {
        didSet {
            _displayMovies$.onNext(movies)
        }
    }
    private let provider: MoyaProvider<MovieService>
    private let firebaseService: FirebaseService
    private var _displayMovies$ = PublishSubject<[Movie]>()
    private let _showAlert$ = PublishSubject<UIAlertController>()
    private let disposeBag = DisposeBag()
    
    init(movies: [Movie], provider: MoyaProvider<MovieService> = MoyaProvider<MovieService>()) {
        self.movies = movies
        self.provider = provider
        self.firebaseService = FirebaseService()
    }

    func loadMovies() {
        firebaseService.getMovies()
            .subscribe(onNext: { [weak self ] movies in
                self?.movies =  movies
            }, onError: { [weak self] error in
                guard let self = self else { return }
                let alert = self.createErrorAlert(message: error.localizedDescription)
                self._showAlert$.onNext(alert)
            })
            .disposed(by: disposeBag)
    }
    
    private func createErrorAlert( message: String?) -> UIAlertController {
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        let alert = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        return alert
    }    
}
