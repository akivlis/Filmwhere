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
    case movies
    case movie(identifier: String)
    case scenesForMovieWith(identifier: String)
    case scene(identifier: String)
}

extension MovieService: TargetType {
    
    var baseURL: URL { return Endpoint.apiBaseURL }

    var path: String {
        switch self {
        case .movies:
            return "movies"
        case let .movie(identifier):
            return "movies/\(identifier)"
        default:
            return "movies"
        }
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
