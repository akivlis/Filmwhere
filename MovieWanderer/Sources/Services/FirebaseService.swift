//
//  FirebaseService.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 13.10.21.
//  Copyright © 2021 Silvia Kuzmova. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import FirebaseFirestoreSwift

class FirebaseService {

    let db = Firestore.firestore()

    init() {
    }

    func getMovies() -> Observable<[Movie]> {
        Observable.create { observer -> Disposable in

            self.db.collection("movies").getDocuments() { (querySnapshot, err) in
                if let error = err {
                    print("Error getting documents: \(error)")
                    observer.onError(error)
                    observer.onCompleted()

                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("no documents")
                        observer.onError(MovieError.noData)
                        observer.onCompleted()
                        return
                    }

                    documents.forEach { document in
                        print("❤️ \n")
                        print(document.data())
                        print("\n \n")
                    }

                    let result = Result {
                        try documents.compactMap {
                            try $0.data(as: Movie.self)
                        }
                    }

                    switch result {
                    case .success(let movies):
                            print(" ❤️ movies: \(movies)")
                            observer.onNext(movies)
                        observer.onCompleted()
                    case .failure(let error):
                        print("Error decoding movies: \(error)")
                        observer.onError(error)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }

    func getScenes(for movieID: String) -> Observable<[Scene]>{
        Observable.create { observer -> Disposable in

            let scenesRef = self.db.collection("movies").document(movieID).collection("scenes")

            scenesRef.getDocuments() { (querySnapshot, err) in
                if let error = err {
                    print("Error getting documents: \(error)")
                    observer.onError(error)
                    observer.onCompleted()

                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("no documents")
                        observer.onError(MovieError.noData)
                        observer.onCompleted()
                        return
                    }

                    documents.forEach { document in
                        print("🐣\n")
                        print(document.data())
                        print("\n")
                    }

                    let result = Result {
                        try documents.compactMap {
                            try $0.data(as: Scene.self)
                        }
                    }

                    switch result {
                    case .success(let scenes):
                            print(" 🐣 scenes: \(scenes)")
                            observer.onNext(scenes)
                        observer.onCompleted()
                    case .failure(let error):
                        print("Error decoding scenes: \(error)")
                        observer.onError(error)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }

    func getAllScenes() -> Observable<[Scene]>{
        Observable.create { observer -> Disposable in

            let scenesRef = self.db.collectionGroup("scenes")
            //whereField - can be used to filter based on location, if its closed to me

            scenesRef.getDocuments() { (querySnapshot, err) in
                if let error = err {
                    print("Error getting documents: \(error)")
                    observer.onError(error)
                    observer.onCompleted()

                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("no documents")
                        observer.onError(MovieError.noData)
                        observer.onCompleted()
                        return
                    }

                    let result = Result {
                        try documents.compactMap {
                            try $0.data(as: Scene.self)
                        }
                    }

                    switch result {
                    case .success(let scenes):
                            print(" 🐛 ALL scenes: \(scenes)")
                            observer.onNext(scenes)
                        observer.onCompleted()
                    case .failure(let error):
                        print("Error decoding scenes: \(error)")
                        observer.onError(error)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
}

enum MovieError: Error {
    case noData
}
