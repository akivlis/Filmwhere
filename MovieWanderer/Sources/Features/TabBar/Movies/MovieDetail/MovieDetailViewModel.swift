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
import Combine

class MovieDetailViewModel {

    private let scenesSubject = CurrentValueSubject<[Scene], Never>([Scene]())
    private(set) lazy var scenesPublisher = scenesSubject
        .eraseToAnyPublisher()

    private let showAlertSubject = PassthroughSubject<UIAlertController, Never>()
    private(set) lazy var showAlertPublisher = showAlertSubject
        .eraseToAnyPublisher()

    private let firebaseService: FirebaseService
    private let disposeBag = DisposeBag()

    let movie: Movie

    // MARK: - Init
    
    init(movie: Movie,
         firebaseService: FirebaseService = FirebaseService()
    ) {
        self.movie = movie
        self.firebaseService = firebaseService
    }
    
    var movieHeaderViewModel: MovieHeaderViewModel {
        return MovieHeaderViewModel(movie: movie)
    }
    
    var title: String {
        return movie.title
    }
    
    var scenes: [Scene] {
        return scenesSubject.value
    }

    func loadScenes() {
        guard let id = movie.id else { return }
        firebaseService.getScenes(for: id)
            .subscribe(onNext: { [weak self ] scenes in
                self?.scenesSubject.send(scenes)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                let alertController = UIAlertController.warningAlert(title: "Error", message: error.localizedDescription)
                self.showAlertSubject.send(alertController)
            })
            .disposed(by: disposeBag)
    }
}
