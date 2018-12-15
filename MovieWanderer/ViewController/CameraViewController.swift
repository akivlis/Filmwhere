//
//  CameraViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 12.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class CameraViewController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showsCameraControls = false
        
        
        let overlayView = CameraOverlayView(frame: self.view.frame)
        
        self.cameraOverlayView = overlayView
        
        overlayView.takePictureButton.rx.tapGesture()
            .subscribe(onNext: { _ in
                print("Take picture button tapped")
                self.takePicture()
            })
        
    }
    
    
}
