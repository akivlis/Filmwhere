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
    
    init(title: String, description: String, scenes: [Scene]) {
        self.title = title
        self.description = description
        self.scenes = scenes
    }
    
    
}
