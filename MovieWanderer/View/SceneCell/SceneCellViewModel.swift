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

    var sceneImage: UIImage {
        if let image = UIImage(named: scene.title) {
            return image
        }
        // TODO: remove a make it optiona
        return UIImage(named: "Dany")!
    }
}

