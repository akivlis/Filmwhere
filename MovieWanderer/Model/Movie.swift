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
    let sceneCount: Int
    let imageUrl: String
    
    init(id: String = "", title: String, description: String, scenes: [Scene], sceneCount: Int = 1, imageUrl: String) {
        self.id = id
        self.title = title
        self.description = description
        self.scenes = scenes
        self.imageUrl = imageUrl
        self.sceneCount = sceneCount
    }    
}

extension Movie: Decodable {
    
    fileprivate enum Keys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl
        case sceneCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let title: String = try container.decode(String.self, forKey: .title)
        let description: String = try container.decode(String.self, forKey: .description)
        let imageUrl: String = try container.decode(String.self, forKey: .imageUrl)
        let sceneCount: Int = try container.decode(Int.self, forKey: .sceneCount)
        self.init(id: id, title: title, description: description, scenes: [Scene](), sceneCount: sceneCount, imageUrl: imageUrl)
    }
}
