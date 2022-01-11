//
//  LocationViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import Combine
import RxSwift

class LocationViewModel {

    private let scenesSubject = CurrentValueSubject<[Scene], Never>([Scene]())
    private(set) lazy var scenesPublisher = scenesSubject
        .eraseToAnyPublisher()

    private let firebaseService: FirebaseService
    private let disposeBag = DisposeBag()

    var scenes: [Scene] {
        return scenesSubject.value
    }

    // MARK: - Init

    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }

    func loadAllScenes() {
        firebaseService.getAllScenes()
            .subscribe(onNext: { [weak self ] scenes in
                self?.scenesSubject.send(scenes)
            }, onError: { [weak self] error in
                guard let self = self else { return }
//                let alert = self.createErrorAlert(message: error.localizedDescription)
                print(error)
//                self._showAlert$.onNext(alert)
            })
            .disposed(by: disposeBag)
    }
}
