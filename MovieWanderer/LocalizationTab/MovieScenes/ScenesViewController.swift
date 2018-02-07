//
//  ScenesViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class ScenesViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        
        //create dummy scenes
        let scenes : [Scene] = [Scene(title: "Walk of shame", description: "Bla bla bla", position: "fsfs"),
                                Scene(title: "Red wedding", description: "Stark family got killed", position: "fsfjsk"),
                                Scene(title: "On the Wall", description: "John snow knows nothing", position: "fnsjfns")]
        
        let sceneView = SceneView(scenes: scenes)
        
        view.addSubview(sceneView)
        sceneView.autoPinEdgesToSuperviewEdges()

    }

}
