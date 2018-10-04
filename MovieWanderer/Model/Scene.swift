//
//  Scene.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 07/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

class Scene {
    
    let id: String
    let title: String
    let description: String
    let latitude: Double
    let longitude: Double
    let imageURL: String
    let country : String

    
    init(id: String = "", title: String, description: String, latitude: Double, longitude: Double, imageURL: String = "imageURL", country: String = "Philadelphia, USA") {
        self.id = id
        self.title = title
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.country = country
        self.imageURL = imageURL
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


