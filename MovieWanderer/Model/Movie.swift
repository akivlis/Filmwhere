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
    let scenes: [Scene]
    let numberOfScenes: Int
    let imageName: String
    
    init(id: String = "", title: String, description: String, scenes: [Scene], imageName: String) {
        self.id = id
        self.title = title
        self.description = description
        self.scenes = scenes
        self.imageName = imageName
        self.numberOfScenes = scenes.count
    }    
}
