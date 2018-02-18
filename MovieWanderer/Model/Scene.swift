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
    let latitude: Double
    let longitude: Double

    
    init(title: String, description: String, latitude: Double, longitude: Double) {
        self.title = title
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
}
