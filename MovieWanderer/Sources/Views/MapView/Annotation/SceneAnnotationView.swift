//
//  SceneAnnotationView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import MapKit
import RxSwift

class SceneAnnotationView: MKAnnotationView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.lightGray
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.brightPink.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var navigateButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        let image = UIImage(named: "navigation_icon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .lightPink
        return button
    }()
    
    private let normalWidth = CGFloat(30)
    private let scaledUpWidth = CGFloat(40)

    
    // MARK: Init
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
  
        if let annotation = annotation as? SceneAnnotation {
            imageView.kf.setImage(with: annotation.imageURL)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    func scaleImage(_ scaling: ScalingDirection) {
        let newWidth = scaling == .up ? scaledUpWidth : normalWidth
        
        imageView.layer.cornerRadius = newWidth / 2
        imageView.snp.updateConstraints { make in
            make.width.height.equalTo(newWidth)
        }
    }
}

// MARK: - Private

private extension SceneAnnotationView {
    func setupViews() {
        self.frame = CGRect(x: 0, y: 0, width: normalWidth, height: normalWidth)
        backgroundColor = UIColor.clear
        
        rightCalloutAccessoryView = navigateButton
        isEnabled = true
        canShowCallout = true
        
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(normalWidth)
            make.centerX.equalToSuperview()
        }
    }
}

enum ScalingDirection {
    case up, down
}
