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
    
    let pictures: [UIImage]
    
    init(pictures: [UIImage]) {
        self.pictures = pictures
        super.init(dismissOnPullDown: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.pictures = [UIImage]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        
        canRotate()
        
        //TODO: implement for multiple pictures
        if let picture = pictures.first {
            currentImageView.image = picture
        } else {
            currentImageView.image = nil
        }
        
        view.addTopGradient()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func canRotate() -> Void {}
}
