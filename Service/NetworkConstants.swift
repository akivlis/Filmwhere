//
//  NetworkConstants.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 01.11.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation


struct NetworkConstants {
    
    static let apiBaseURL: URL = {
        let urlString = "http://ec2-18-185-11-138.eu-central-1.compute.amazonaws.com:8080/api"
        return URL(string: String(format: "%@/%@", urlString, apiVersion))!
    }()
    
    static let apiVersion: String = "v1"
    
}
