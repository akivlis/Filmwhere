//
//  PictureViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 02.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

class PictureViewController: BaseCloseViewController {

    @IBOutlet weak var currentImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canRotate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        
    }
    
      @objc func canRotate() -> Void {}
}
