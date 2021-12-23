//
//  Movie.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct Movie: Codable, Identifiable {
    
    @DocumentID var id: String?
    let title: String
    let description: String
    let scenes: [Scene]
    let imageURL: URL?
}

extension Movie {

    fileprivate enum Keys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl = "imageUrlString"
        case scenes
    }
}
