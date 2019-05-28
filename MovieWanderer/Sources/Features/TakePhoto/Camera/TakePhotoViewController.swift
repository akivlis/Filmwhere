//
//  TakePhotoViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 12.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

class TakePhotoViewController: UIViewController {
    
    @IBOutlet weak var captureButton : RecordButton!
    @IBOutlet weak var flipCameraButton : UIButton!
    @IBOutlet weak var flashButton : UIButton!
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet fileprivate var capturePreviewView: UIView!

    
    let cameraController = CameraViewController()
  
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        setupConstraints()
        setupObservables()
        setupCamera()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func changedValue(_ sender: UISlider) {
        let alphaValue = sender.value
        overlayImageView.alpha = CGFloat(alphaValue)
    }
}


private extension TakePhotoViewController {
    
    private func setupCamera() {
        
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        // disable capture button until session starts
//        captureButton.buttonEnabled = false

        
    }
    

    
    private func setupViews() {
        let backgroundImage = UIImage(named: "eat_pray")!
        let rotatedPhoto = backgroundImage.fixedOrientation().imageRotatedByDegrees(degrees: 90.0)
        
        overlayImageView.image = rotatedPhoto
        overlayImageView.alpha = 0.5
        
        alphaSlider.addTarget(self, action: #selector(changedValue(_:)), for: .valueChanged)
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupObservables() {
        closeButton.rx.tapGesture()
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        captureButton.rx.tap
            .subscribe(onNext: { _ in
                print("capture button tap")
                // take(photo)
            })
        .disposed(by: bag)
    }
    
    private func take(_ photo: UIImage) {
        let originalImage = UIImage(named: "eat_pray")!
        let newVC = SplitPhotoViewController(originalImage: originalImage, newImage: photo)
        
        self.present(newVC, animated: true, completion: nil)
    }
}

