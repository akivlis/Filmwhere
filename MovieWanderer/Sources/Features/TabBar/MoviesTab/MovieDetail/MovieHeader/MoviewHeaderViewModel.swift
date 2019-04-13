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
        return movie.title
    }
    
    var description: String {
        return movie.description
    }
 
    var isFavorite: Bool {
        //TODO: add proper logic
        return true
    }
    
    var imageUrl: URL? {
        return movie.imageURL
    }
    
    var placeholderImage: UIImage {
        return UIImage(named: "placeholder")!
    }
    
}
