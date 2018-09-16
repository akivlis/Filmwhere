//
//  MovieService.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 15.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import Moya

enum MovieService {
    case showMovies
    case showMovie(identifier: Int)
    case scenesForMovieWith(identifier: Int)
    case scene(identifier: Int)
}

extension MovieService: TargetType {
    var baseURL: URL {
        var baseURL: URL { return URL(string: "https://api.myservice.com")! }
        return baseURL
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
