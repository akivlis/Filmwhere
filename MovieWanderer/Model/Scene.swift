//
//  Scene.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 07/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

struct Scene {
    
    let id: String
    let title: String
    let description: String
    let locationName: String
    let latitude: Double
    let longitude: Double
    let imageURL: String
    let country : String

    
    init(id: String = "",
         title: String,
         description: String,
         locationName: String = "Art Museum Stairs",
         latitude: Double,
         longitude: Double,
         imageURL: String = "imageURL",
         country: String = "Philadelphia, USA"
        )
    {
        self.id = id
        self.title = title
        self.description = description
        self.locationName = locationName
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

extension Scene: Decodable {
    
    fileprivate enum Keys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl
        case latitude
        case longitude
        case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let title: String = try container.decode(String.self, forKey: .title)
        let description: String = try container.decode(String.self, forKey: .description)
        let imageUrl: String = try container.decode(String.self, forKey: .imageUrl)
        let latitude: Double = try container.decode(Double.self, forKey: .latitude)
        let longitude: Double = try container.decode(Double.self, forKey: .longitude)
        let country: String = try container.decode(String.self, forKey: .description)
        self.init(id: id, title: title, description: description, latitude: latitude, longitude: longitude, imageURL: imageUrl, country: country)
    }
}


