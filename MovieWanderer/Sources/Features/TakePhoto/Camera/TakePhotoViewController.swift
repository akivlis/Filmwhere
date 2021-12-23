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
    
    private let cameraController = CameraViewController()
    private let bag = DisposeBag()
    private let sceneImage: UIImage
    private let movieTitle: String
    
    init(sceneImage: UIImage, movieTitle: String) {
        self.sceneImage = sceneImage
        self.movieTitle =  movieTitle
        super.init(nibName: TakePhotoViewController.className(), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        setupConstraints()
        setupObservables()
        setupCamera()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isBeingDismissed) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    open override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func changedValue(_ sender: UISlider) {
        let alphaValue = sender.value
        overlayImageView.alpha = CGFloat(alphaValue)
    }
}

// MARK: - Private

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
        overlayImageView.image = sceneImage
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
        cameraController.captureImage { image, error in
            guard let capturedImage = image else {
                print(error ?? "Image capture error")
                return
            }
            let rotatedPhoto = self.getRotatedPicture(of: capturedImage)
            
            let splitViewController = SplitPhotoViewController(originalImage: self.sceneImage,
                                                               newImage: rotatedPhoto,
                                                               movieTitle: self.movieTitle)
            self.present(splitViewController, animated: true, completion: nil)
        }
    }
    
    private func getRotatedPicture(of image: UIImage) -> UIImage {
        switch cameraController.currentCameraPosition {
        case .some(.front):
            return image.fixedOrientation().imageRotatedByDegrees(degrees: 90.0)
        case .some(.rear):
            return image.fixedOrientation().imageRotatedByDegrees(degrees: -90.0)
        case .none:
            return image
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

