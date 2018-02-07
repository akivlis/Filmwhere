//
//  Scene.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 07/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

struct Scene {
    
    let title: String
    let description: String
    let position: String
    
    init(title: String, description: String, position: String) {
        self.title = title
        self.description = description
        self.position = position
    }
}
