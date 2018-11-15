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
        
        switch scene.title {
        case "Rocky":
             return "During the “Gonna Fly Now” training montage in the original Rocky, Sylvester Stallone is seen in his grey sweatsuit running alongside Philadelphia’s Schuylkill River with an arched stone bridge behind him. The bridge has been identified as Philly’s Connecting Railway Bridge, built in 1866, and Rocky jogs south along the Kelly Drive bike trail in the movie. During the late 19th century, the Connecting Railway Bridge was a frequent subject for scenic paintings of Philadelphia."
        default:
             return "During the “Gonna Fly Now” training montage in the original Rocky, Sylvester Stallone is seen in his grey sweatsuit running alongside Philadelphia’s "
        }
        
        //TODO: change
        return "During the “Gonna Fly Now” training montage in the original Rocky, Sylvester Stallone is seen in his grey sweatsuit running alongside Philadelphia’s Schuylkill River with an arched stone bridge behind him. The bridge has been identified as Philly’s Connecting Railway Bridge, built in 1866, and Rocky jogs south along the Kelly Drive bike trail in the movie. During the late 19th century, the Connecting Railway Bridge was a frequent subject for scenic paintings of Philadelphia."
    }
    
    var imageUrl: URL {
        return URL(string: scene.imageURL)!
    }
    
    var placeholderImage: UIImage {
        return UIImage(named: "eat_pray")!
    }
}
