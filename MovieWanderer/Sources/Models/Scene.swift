//
//  Scene.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 07/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Scene: Codable {
    
    @DocumentID var id: String?
    let title: String
    let description: String
    let locationName: String
    let location: GeoPoint
    var imageURLString: String = ""
    let country : String
    var movieTitle: String?
    var movieURLString: String = ""

    var movieURL: URL? {
        return URL(string: movieURLString)
    }

    var imageURL: URL? {
        return URL(string: imageURLString)
    }
}

//extension Scene: Equatable {
//    static func == (lhs: Scene, rhs: Scene) -> Bool {
//        return lhs.title == rhs.title &&
//            lhs.description == rhs.description &&
//            lhs.location == rhs.location
//    }
//}


