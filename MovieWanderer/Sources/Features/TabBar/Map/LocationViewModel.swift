//
//  LocationViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation


struct LocationViewModel {
    
    let scenes: [Scene]
    let movies: [Movie]
    
    init(scenes: [Scene]) {
        self.scenes = scenes
        self.movies = [Movie]()
    }
    
    init(movies: [Movie]) {
        self.movies = movies
        self.scenes = movies.flatMap { $0.scenes }
    }
    
    func getMovie(for text: String) -> [Movie]? {
        return movies.filter { $0.title.lowercased().contains(text.lowercased()) }
    }
}
