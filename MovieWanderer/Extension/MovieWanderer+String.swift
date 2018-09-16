//
//  MovieWanderer+String.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 15.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

// MARK: - Helpers

 extension String {
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
