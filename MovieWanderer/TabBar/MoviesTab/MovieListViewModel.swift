//
//  MovieListViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 01.11.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class MovieListViewModel {
    
    private var _displayMovies$ = PublishSubject<[Movie]>()
    var displayMovies$: Observable<[Movie]> {
        return _displayMovies$
    }
    
    private let _showAlert$ = PublishSubject<UIAlertController>()
    var showAlert$: Observable<UIAlertController> {
        return _showAlert$
    }
    
    private let provider: MoyaProvider<MovieService>
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(provider: MoyaProvider<MovieService> = MoyaProvider<MovieService>()) {
        self.provider = provider
    }
    
    func loadMovies() {
        provider.rx.request(.movies)
            .map([Movie].self)
            .subscribe(onSuccess: { [weak self] movies in
                self?._displayMovies$.onNext(movies)
            }) { [weak self] error in
                guard let strongSelf = self else { return }
                let alert = strongSelf.createErrorAlert(message: error.localizedDescription)
                strongSelf._showAlert$.onNext(alert)
//                strongSelf._displayMovies$.onNext(strongSelf.dummyMovies())
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Helper
    
    private func createErrorAlert( message: String?) -> UIAlertController {
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        let alert = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        return alert
    }
    
    private func dummyMovies() -> [Movie] {
        let dummyScenes : [Scene] = [
            Scene(title: "Rocky", description: "Hahaha", latitude:39.962920, longitude: -75.157235, imageURL: "Rocky_running"),
            Scene(title: "Stairs", description: "Dubrovnik", latitude: 42.645942, longitude: 18.090084),
            Scene(title: "Mission Impossible", description: "Vienn Opera", latitude:  48.202840, longitude: 16.368916),
            Scene(title: "Red Sparrow", description: "Hofburg", latitude:  48.208347, longitude: 16.366143),
            Scene(title: "Roman holiday", description: "Spanish stairs", latitude:  41.899355, longitude: 12.484746)
        ]
        
        let viennaScenes = [
            Scene(title: "Mission Impossible", description: "Vienn Opera", latitude:  48.202840, longitude: 16.368916),
            Scene(title: "Red Sparrow", description: "Hofburg", latitude:  48.208347, longitude: 16.366143)
        ]
        
        let gameOfThronesScenes = [Scene(title: "Jamie", description: "Hahaha", latitude: 48.225660, longitude: 16.399509),
                                   Scene(title: "Lokrum", description: "Hihihhi", latitude: 48.228176, longitude: 16.395046),
                                   Scene(title: "Stairs", description: "Bla bla bla", latitude: 48.206959, longitude: 16.390454),
                                   Scene(title: "Dany", description: "Bla bla bla", latitude:  48.157614, longitude: 17.075666)
        ]
        
        let dummyMovies =  [
            Movie(title: "Eat, Pray, Love", description: "Liz Gilbert (Julia Roberts) thought she had everything she wanted in life: a home, a husband and a successful career. Now newly divorced and facing a turning point, she finds that she is confused about what is important to her. Daring to step out of her comfort zone, Liz embarks on a quest of self-discovery that takes her to Italy, India and Bali.", scenes: viennaScenes, imageUrl: "eat_pray"),
            Movie(title: "Game Of Thrones", description: "Game of thrones is an american", scenes: gameOfThronesScenes, imageUrl: "Rocky"),
            Movie(title: "Rocky", description: "A boxer decides to change his life, so he starts training for the worlds biggest competition in Philadephia. He needs to put all his forces into this fight and so on and on ", scenes: dummyScenes, imageUrl: "Rocky_running"),
            ]
        
        return dummyMovies
    }
}
