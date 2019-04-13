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
    let location: (latitude: Double, longitude: Double)
    let imageURL: String
    let country : String
    var movieTitle: String?
    var movieURL: URL?
    
    init(id: String,
         title: String,
         description: String,
         locationName: String,
         location: (latitude: Double, longitude: Double),
         imageURL: String,
         country: String,
         movieTitle: String? = ""
        )
    {
        self.id = id
        self.title = title
        self.description = description
        self.locationName = locationName
        self.location = location
        self.country = country
        self.imageURL = imageURL
        self.movieTitle = movieTitle
    }
}

extension Scene: Equatable {
    static func == (lhs: Scene, rhs: Scene) -> Bool {
        return lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.location == rhs.location
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
        case locationName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let title: String = try container.decode(String.self, forKey: .title)
        let description: String = try container.decode(String.self, forKey: .description)
        let locationName: String = try container.decode(String.self, forKey: .locationName)
        let imageUrl: String = try container.decode(String.self, forKey: .imageUrl)
        let latitude: Double = try container.decode(Double.self, forKey: .latitude)
        let longitude: Double = try container.decode(Double.self, forKey: .longitude)
        let country: String = try container.decode(String.self, forKey: .country)
        self.init(id: id, title: title, description: description, locationName: locationName, location: (latitude, longitude), imageURL: imageUrl, country: country)
    }
}


