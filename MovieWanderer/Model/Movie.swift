//
//  Movie.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

struct Movie {
    
    let title: String
    let description: String
    let scenes: [Scene]
    let year: String
    let numberOfLocations: Int
    let image: String
    
    init(title: String, description: String, scenes: [Scene], year: String = "2015", numberOfLocations: Int = 15, image: String) {
        
        self.title = title
        self.description = description
        self.scenes = scenes
        self.year = year
        self.numberOfLocations = numberOfLocations
        self.image = image
    }
    
    
}
