//
//  MoviewHeaderViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 28.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit


struct MovieHeaderViewModel {
    
    let movie: Movie

    // MARK: - Computed properties
    
    var title: String {
        return movie.title //+ " " + year
    }
    
    var description: String {
        return movie.description
    }
    
    var year: String {
        //TODO: return year in specific format
        return movie.year
    }
    
//    var numberOfFilmingLocations: String {
//        return "\(movie.numberOfLocations) filming locations"
//    }
    
    var isFavorite: Bool {
        //TODO: add proper logic
        return true
    }
    
    var movieImage: UIImage {
        return UIImage(named: movie.imageName)!
    }
    
}
