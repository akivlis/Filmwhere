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
    
    var allScenes: [Scene] {
        return movies.flatMap { $0.scenes }
    }
    
    private var movies: [Movie] {
        didSet {
            _displayMovies$.onNext(movies)
        }
    }
    private let provider: MoyaProvider<MovieService>
    private var _displayMovies$ = PublishSubject<[Movie]>()
    private let disposeBag = DisposeBag()
    
    init(movies: [Movie], provider: MoyaProvider<MovieService> = MoyaProvider<MovieService>()) {
        self.movies = movies
        self.provider = provider
    }

    func loadMovies() {
        provider.rx.request(.movies)
            .map([Movie].self)
            .subscribe(onSuccess: { [weak self] movies in
                self?.movies = movies
//                self?._displayMovies$.onNext(movies)
            }) { [weak self] error in
                print(error)
//                guard let strongSelf = self else { return }
//                let alert = strongSelf.createErrorAlert(message: error.localizedDescription)
//                strongSelf._showAlert$.onNext(alert)
                //                strongSelf._displayMovies$.onNext(strongSelf.dummyMovies())
            }.disposed(by: disposeBag)
    }
    
}
