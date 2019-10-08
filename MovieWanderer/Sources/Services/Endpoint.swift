//
//  Endpoint.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 01.11.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

struct Endpoint {
    
    static let apiBaseURL: URL = {
        let urlString = "http://ec2-18-184-213-235.eu-central-1.compute.amazonaws.com:8080/api"
        return URL(string: String(format: "%@/%@", urlString, apiVersion))!
    }()
    
    static let apiVersion: String = "v1"

}
