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
    var scenes: [Scene]? = [Scene]()
    let imageURLString: String

    var imageURL: URL? {
        return URL(string: imageURLString)
    }
}
