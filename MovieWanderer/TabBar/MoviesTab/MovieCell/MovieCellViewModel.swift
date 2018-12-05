//
//  MovieCellViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

struct MovieCellViewModel {
    
    let movie: Movie
    
    var subtitle: String {
        return movie.description
    }
    
    var imageUrl: URL {
        return URL(string: movie.imageUrl)!
    }
    
    var placeholderImage: UIImage {
        return UIImage(named: "eat_pray")!
    }
    
    var title: String {
        return movie.title
    }
    
    var numberOfScenes: String {
        let placesString = movie.scenes.count > 1 ? "places" : "place"
        return "\(movie.scenes.count) \(placesString)"
    }
}
