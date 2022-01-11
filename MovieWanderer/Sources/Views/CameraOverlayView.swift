//
//  CameraOverlayView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 13.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView {
    
    let originalPhotoImageView = UIImageView()
    let takePictureButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        takePictureButton.layer.cornerRadius = takePictureButton.frame.width / 2
    }
}

private extension CameraOverlayView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        backgroundColor = UIColor.red.withAlphaComponent(0.5)
        
        let dummyPhoto = UIImage(named: "eat_pray_love")
        originalPhotoImageView.image = dummyPhoto
        originalPhotoImageView.alpha = 0.5
        addSubview(originalPhotoImageView)
        
        takePictureButton.backgroundColor = .systemBackground
        addSubview(takePictureButton)
    }
    
    private func setupConstraints() {
        originalPhotoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.top.equalTo(self.snp.centerY)
        }
        
        takePictureButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
}
