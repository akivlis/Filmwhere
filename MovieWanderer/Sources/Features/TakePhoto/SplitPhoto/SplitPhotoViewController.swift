//
//  SplitPhotoViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 23.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Photos

class SplitPhotoViewController: UIViewController {
    
    @IBOutlet weak var photosContainer: UIView!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var normalPhotoButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var squarePhotoButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    private var heightConstraint : Constraint?
    private let disposeBag = DisposeBag()
    private let originalImage: UIImage
    private let newImage: UIImage
    private let movieTitle: String
    
    init(originalImage: UIImage, newImage: UIImage, movieTitle: String) {
        self.originalImage = originalImage
        self.newImage = newImage
        self.movieTitle = movieTitle
        super.init(nibName: "SplitPhotoViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.originalImageView.image = originalImage
        self.newImageView.image = newImage
        
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

private extension SplitPhotoViewController {
    
    private func setupViews() {
        view.backgroundColor = UIColor.black
        
        originalImageView.layer.borderColor = UIColor.white.cgColor
        originalImageView.layer.borderWidth = 2

        newImageView.layer.borderColor = UIColor.white.cgColor
        newImageView.layer.borderWidth = 2
    }
    
    private func setupConstraints() {
        photosContainer.snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(photosContainer.snp.width).multipliedBy(4.0/3.0).constraint
        }
    }
    
    private func setupObservables() {
        squarePhotoButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] recognizer in
                self?.changePhotoAspectRatio(to: .square)
            })
            .disposed(by: disposeBag)
        
        normalPhotoButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] recognizer in
                self?.changePhotoAspectRatio(to: .normal)
            })
            .disposed(by: disposeBag)
        
        shareButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] recognizer in
                self?.shareImage()
            })
            .disposed(by: disposeBag)
        
        closeButton.rx.tapGesture()
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func changePhotoAspectRatio(to aspectRatio: PhotoAspectRatio) {
        heightConstraint?.deactivate()
        photosContainer.snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(photosContainer.snp.width).multipliedBy(aspectRatio.multiplier).constraint
        }
    }
    
    private func shareImage() {
        let finalImage =  photosContainer.asImage()
        
        let textProvider = TextProvider(viewModel: TextProviderViewModel(movieTitle: movieTitle))
        let activityViewController = UIActivityViewController(activityItems: [finalImage, textProvider], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { (activityType, completed, _, _) in
            if activityType == .saveToCameraRoll {
                var message: String?
                var title = ""
                
                if completed {
                    title = "Saved"
                    message = "Photo was succesfully saved to your library :)"
                } else {
                    title = "Oops"
                    message = "The photo was not saved to your library. Pls try again :)"
                }
                let alert = UIAlertController.createAlertController(withTitle: title, message: message, closeActionTitle: "OK")
                self.present(alert, animated: true, completion: nil)
            }
        }
        present(activityViewController, animated: true)
    }
}

fileprivate enum PhotoAspectRatio {
    
    case normal, square
    
    var multiplier: CGFloat {
        switch self {
        case .normal:
            return 4.0/3.0
        case .square:
            return 1/1
        }
    }
}

