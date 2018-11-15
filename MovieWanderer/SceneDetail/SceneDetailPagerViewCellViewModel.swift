//
//  SceneDetailPagerViewCellViewModel.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 22.10.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

struct SceneDetailPagerViewCellViewModel {
    
    let scene: Scene
    
    var description: String {
       return scene.description
    }
    
    var imageUrl: URL {
        return URL(string: scene.imageURL)!
    }
    
    var placeholderImage: UIImage {
        return UIImage(named: "eat_pray")!
    }
}
