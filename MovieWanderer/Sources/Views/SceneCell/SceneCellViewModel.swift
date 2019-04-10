//
//  SceneCellViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit

struct SceneCellViewModel {
    
    let scene: Scene
    
    var title : String {
        return scene.title
    }
    
    var description: String {
        return scene.description
    }
    
    var address: String {
        return scene.country
    }
    
    var distanceFromMe: String {
        return "50 km"
    }

    var imageUrl: URL {
        return URL(string: scene.imageURL)!
    }
    
    var placeholderImage: UIImage {
        return UIImage(named: "placeholder")!
    }
}

