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
    
    let scene: Place
    
    var title : String {
        return scene.title
    }
    
    var description: String {
        return "Very long test movie scene description which says something important about the scene" 
        return scene.description
    }
    
    var address: String {
        return scene.country
    }
    
    var distanceFromMe: String {
        return "50 km"
    }

    var sceneImage: UIImage {
        if let image = UIImage(named: scene.title) {
            return image
        }
        return UIImage(named: "Dany")!
    }
}

