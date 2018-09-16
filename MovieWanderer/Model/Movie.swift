//
//  Movie.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

struct Movie {
    
    let id: String
    let title: String
    let description: String
    let places: [Place]
    let numberOfPlaces: Int
    let imageName: String
    
    init(id: String = "", title: String, description: String, places: [Place], numberOfPlaces: Int = 15, imageName: String) {
        self.id = id
        self.title = title
        self.description = description
        self.places = places
        self.numberOfPlaces = numberOfPlaces
        self.imageName = imageName
    }    
}
