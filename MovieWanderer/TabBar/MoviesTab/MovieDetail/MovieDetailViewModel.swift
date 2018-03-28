//
//  MovieDetailViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
    
    let movie: Movie
    
    var movieHeaderViewModel: MovieHeaderViewModel {
        return MovieHeaderViewModel(movie: movie)
    }
    
}
