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
    case movie(identifier: Int)
    case scenesForMovieWith(identifier: Int)
    case scene(identifier: Int)
}

extension MovieService: TargetType {
    
    var baseURL: URL { return NetworkConstants.apiBaseURL }

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


//var baseURL: URL { return NetworkConstants.apiBaseURL }
//
//var path: String {
//    switch self {
//    case .challenges:
//        return "challenges"
//    case let .challenge(identifier):
//        return "challenges/\(identifier)"
//    case let .runChallenge(identifier, language, _):
//        return "challenges/\(identifier)/code/\(language)/run"
//    }
//}
//
//var method: Moya.Method {
//    switch self {
//    case .runChallenge:
//        return .post
//    default:
//        return .get
//    }
//}
//
//var task: Task {
//    switch self {
//    case let .challenges(secondsToUnlock):
//        if let seconds = secondsToUnlock {
//            return .requestParameters(parameters: ["secondsToUnlock": seconds], encoding: URLEncoding.default)
//        } else {
//            return .requestPlain
//        }
//    case let .runChallenge(_, _, code):
//        return .requestParameters(parameters: ["code": code], encoding: JSONEncoding.default)
//    default:
//        return .requestPlain
//    }
//}
//
//var sampleData: Data {
//    switch self {
//    case .challenges:
//        return "{\"challenges\":[{\"date\":\"2018-06-05\",\"unlocksAt\":\"\(Challenge.iso8601Formatter.string(from: Date(timeIntervalSinceNow: 30 * 60)))\",\"id\":13,\"instructions\":\"Due to advancements in weather tracking technology, the Weather App can detect changes to temperatures in your location better than ever before.\\n\\nHelp display the more accurate data by creating a `temperature` variable (double) and setting its value to `0`.\\n\",\"isSolved\":true,\"name\":\"Upgrade the Weather App 10\"},{\"date\":\"2018-06-06\",\"unlocksAt\":\"\(Challenge.iso8601NoFSFormatter.string(from: Date(timeIntervalSinceNow: -30 * 60)))\",\"id\":12,\"instructions\":\"Due to advancements in weather tracking technology, the Weather App can detect changes to temperatures in your location better than ever before.\\n\\nHelp display the more accurate data by creating a `temperature` variable (double) and setting its value to `0`.\\n\",\"isSolved\":false,\"name\":\"Upgrade the Weather App 12\"},{\"date\":\"2018-06-06\",\"id\":12,\"instructions\":\"Due to advancements in weather tracking technology, the Weather App can detect changes to temperatures in your location better than ever before.\\n\\nHelp display the more accurate data by creating a `temperature` variable (double) and setting its value to `0`.\\n\",\"isSolved\":false,\"name\":\"Upgrade the Weather App 12\"}]}".utf8Encoded
//    case let .challenge(identifier):
//        return "{\"code\":[{\"defaultCode\":\"let requests = 20\\nlet messages = 5\\nlet events = 0\",\"hint\":\"Adding `requests`, `messages`, and `events`, looks something like this:\\n\\n```\\nrequests + messages + events\\n```\",\"isDefaultCodeEditable\":false,\"language\":\"swift\"}],\"date\":\"2018-08-30\",\"id\":\(identifier),\"instructions\":\"Facebook needs your help to build notifications for its mobile app.\\n\\nThey want you to create a `notifications` variable that equals the sum of `requests`, `messages`, and `events`.\\n\\nYour code will help the app display the number of notifications different users have.\",\"name\":\"Build Facebook Notifications\"}".utf8Encoded
//    case .runChallenge:
//        return "{\"hasPassed\":false,\"output\":\"\",\"error\":\"\",\"tests\":[{\"hasPassed\":false,\"name\":\"set autopilot to false\"},{\"hasPassed\":false,\"name\":\"location variable exists\"},{\"hasPassed\":true,\"name\":\"location is a string\"}]}".utf8Encoded
//    }
//}
//
//var headers: [String: String]? {
//    return [
//        "Content-type": "application/json",
//        "Time-Zone": ChallengeService.TimeZoneDateFormatter.string(from: Date()),
//    ]
//}
//
//private static let TimeZoneDateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "ZZZ"
//    return formatter
//}()
