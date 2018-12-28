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

class SplitPhotoViewController: UIViewController {
    
    @IBOutlet weak var photosContainer: UIView!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var normalPhotoButton: UIButton!
    @IBOutlet weak var savePhotoButton: UIButton!
    @IBOutlet weak var squarePhotoButton: UIButton!
        
    private let disposeBag = DisposeBag()
    
    private let originalImage: UIImage
    private let newImage: UIImage
    
    init(originalImage: UIImage, newImage: UIImage) {
        
        self.originalImage = originalImage
        self.newImage = newImage
       
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
        
        photosContainer.backgroundColor = .white
        
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        let cancelImage = UIImage(named: "close-icon")?.withRenderingMode(.alwaysTemplate)
        cancelButton.tintColor = .white
        cancelButton.setImage(cancelImage, for: UIControl.State())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        
        photosContainer.snp.makeConstraints { make in
            make.height.equalTo(photosContainer.snp.width).multipliedBy(4.0/3.0)
        }
       
    }
    
    private func setupObservables() {
        squarePhotoButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] recognizer in
                self?.changePhotoAspectRatio(to: .square)
            }).disposed(by: disposeBag)
        
        normalPhotoButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] recognizer in
                self?.changePhotoAspectRatio(to: .normal)
            }).disposed(by: disposeBag)
    }
    
    private func changePhotoAspectRatio(to: PhotoAspectRatio) {
        photosContainer.snp.updateConstraints { make in
            make.height.equalTo(photosContainer.snp.width)//.multipliedBy(4.0/3.0).constraint
        }
    }
}

fileprivate enum PhotoAspectRatio {
    
    case normal, square
}
