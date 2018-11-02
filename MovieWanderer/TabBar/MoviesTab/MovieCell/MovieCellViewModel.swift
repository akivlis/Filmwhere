//
//  MovieCellViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

struct MovieCellViewModel {
    
    let movie: Movie
    
    var subtitle: String {
        return movie.description
    }
    
    var imageName: String {
        return movie.imageUrl
    }
    
    var title: String {
        return movie.title
    }
   
    
}
