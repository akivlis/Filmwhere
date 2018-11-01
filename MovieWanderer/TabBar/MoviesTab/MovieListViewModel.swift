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

struct MovieListViewModel {
    
    var displayMovies$: Observable<[Movie]> {
        return _displayMovies$
    }
    private var _displayMovies$ = PublishSubject<[Movie]>()
    
    private let provider: MoyaProvider<MovieService>
    
    init(provider: MoyaProvider<MovieService> = MoyaProvider<MovieService>()) {
        self.provider = provider
    }
    
//    provider = MoyaProvider<GitHub>()
//    provider.rx.request(.userProfile("ashfurrow")).subscribe { event in
//    switch event {
//    case let .success(response):
//    image = UIImage(data: response.data)
//    case let .error(error):
//    print(error)
//    }
//    }
//    func loadChallenges(openCurrentChallenge: Bool = false) {
//        provider.rx
//            .request(.challenges(secondsToUnlock: DeveloperMenuViewController.secondsToUnlockNextChallenge))
//            .map([Challenge].self, atKeyPath: "challenges", using: ChallengeDecoder(), failsOnEmptyData: false)
//            .subscribe(onSuccess: { [weak self] challenges in
//                self?.challenges = challenges.reversed()
//                self?.loadedChallenges$.onNext(challenges.reversed())
//
//                if openCurrentChallenge {
//                    self?.openCurrentChallenge.onNext(())
//                }
//            })
//            .disposed(by: disposeBag)
//    }
    
    func loadMovies() {
        
        provider.rx.request(.movies)
            .subscribe(onSuccess: { response in
                print(response)
            }) { error in
                print(error)
        }
        
        
//        _displayMovies$.onNext(dummyMovies)
    }
    
    
    private func dummyMovies() {
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
        
        let dummyMovies =  [ Movie(title: "Eat, Pray, Love", description: "Liz Gilbert (Julia Roberts) thought she had everything she wanted in life: a home, a husband and a successful career. Now newly divorced and facing a turning point, she finds that she is confused about what is important to her. Daring to step out of her comfort zone, Liz embarks on a quest of self-discovery that takes her to Italy, India and Bali.", scenes: viennaScenes, imageName: "eat_pray"),
                             Movie(title: "Game Of Thrones", description: "Game of thrones is an american", scenes: gameOfThronesScenes, imageName: "Rocky"),
                             Movie(title: "Rocky", description: "A boxer decides to change his life, so he starts training for the worlds biggest competition in Philadephia. He needs to put all his forces into this fight and so on and on ", scenes: dummyScenes, imageName: "Rocky_running"),
                             ]
    }
}
