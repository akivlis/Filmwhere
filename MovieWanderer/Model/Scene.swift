//
//  Scene.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 07/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

class Scene {
    
    let title: String
    let description: String
    let latitude: Double
    let longitude: Double
    let country = "Philadelphia, USA" // TODO:

    
    init(title: String, description: String, latitude: Double, longitude: Double) {
        self.title = title
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

extension Scene: Equatable {

    static func == (lhs: Scene, rhs: Scene) -> Bool {
        return lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}


