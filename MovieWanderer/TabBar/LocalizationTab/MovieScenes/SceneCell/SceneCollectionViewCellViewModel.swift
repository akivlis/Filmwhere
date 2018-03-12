//
//  SceneCollectionViewCellViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit

struct SceneCollectionViewCellViewModel {
    
    let scene: Scene
    
    var title : String {
        return scene.title
    }
    
    var subtitle: String {
        return scene.description
    }
    
    var distanceFromMe: Int {
        return 50
    }
    
    var sceneImage: UIImage {
        return UIImage(named: scene.title)!
    }
    
    
}

