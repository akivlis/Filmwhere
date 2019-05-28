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
        captureButton.isEnabled = false
        
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            try? self.cameraController.displayPreview(on: self.capturePreviewView)
            self.captureButton.isEnabled = true
        }
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
            .subscribe(onNext: { [weak self] _ in
                self?.takePhoto()
            })
        .disposed(by: bag)
        
        flashButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.toggleFlash()
            })
            .disposed(by: bag)
        
        flipCameraButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.switchCameras()
            })
            .disposed(by: bag)
    }
    
    private func takePhoto() {
        
        cameraController.captureImage {(image, error) in
            guard let capturedImage = image else {
                print(error ?? "Image capture error")
                return
            }
            let originalImage = UIImage(named: "eat_pray")!
            let newVC = SplitPhotoViewController(originalImage: originalImage, newImage: capturedImage)
            self.present(newVC, animated: true, completion: nil)
            
//            try? PHPhotoLibrary.shared().performChangesAndWait {
//                PHAssetChangeRequest.creationRequestForAsset(from: image)
//            }
        }
    }
    
    func toggleFlash() {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            flashButton.setImage(#imageLiteral(resourceName: "flash_inactive"), for: .normal)
            
        } else {
            cameraController.flashMode = .on
            flashButton.setImage(#imageLiteral(resourceName: "flash_active"), for: .normal)
        }
    }
    
    func switchCameras() {
        do {
            try cameraController.switchCameras()
        } catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            flipCameraButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: .normal)
        case .some(.rear):
            flipCameraButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: .normal)
        case .none:
            return
        }
    }
}

