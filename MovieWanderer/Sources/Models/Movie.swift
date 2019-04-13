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
    let imageURL: URL?
    
    init(id: String = "", title: String, description: String, scenes: [Scene], imageURL: URL?) {
        self.id = id
        self.title = title
        self.description = description
        self.scenes = scenes
        self.imageURL = imageURL
    }
}

extension Movie: Decodable {
    
    fileprivate enum Keys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl
        case scenes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let title: String = try container.decode(String.self, forKey: .title)
        let description: String = try container.decode(String.self, forKey: .description)
        let imageUrlString: String = try container.decode(String.self, forKey: .imageUrl)
        let imageURL = URL(string: imageUrlString)
        var scenes: [Scene] = try container.decodeIfPresent([Scene].self, forKey: .scenes) ?? []
        
        //This is not a very nice solution, but havent found a better way
        for index in scenes.indices {
            scenes[index].movieTitle = title
            scenes[index].movieURL = imageURL
        }
        self.init(id: id, title: title, description: description, scenes: scenes, imageURL: imageURL)
    }
}
