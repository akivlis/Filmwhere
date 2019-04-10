//
//  MovieDetailViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class MovieDetailViewModel {
    
    private var _displayScenes$ = PublishSubject<[Scene]>()
    var displayScenes$: Observable<[Scene]> {
        return _displayScenes$
    }
    
    private let provider: MoyaProvider<MovieService>
    private let disposeBag = DisposeBag()
    
    private(set) var movie: Movie
    
    // MARK: - Init
    
    init(movie: Movie,
         provider: MoyaProvider<MovieService> = MoyaProvider<MovieService>()) {
        self.movie = movie
        self.provider = provider
    }
    
    var movieHeaderViewModel: MovieHeaderViewModel {
        return MovieHeaderViewModel(movie: movie)
    }
    
    var title: String {
        return movie.title
    }
    
    var scenes: [Scene] {
        return movie.scenes
    }
}
