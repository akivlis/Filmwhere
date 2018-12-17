//
//  SceneDetailPagerViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 19.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import FSPagerView
import UIKit
import RxGesture
import RxSwift

class SceneDetailPagerViewCell: FSPagerViewCell {
    
    var scenePhotoTapped$: Observable<UIImage?>{
        return sceneImageView.rx.tapGesture()
            .skip(1) // not sure why this is called first time when the cell is displayed
            .map { _ in self.sceneImageView.image }
            .asObservable()
    }
    
    var navigateButtonTapped$: Observable<()> {
        return navigateButton.rx.tap
            .map { _ in () }
        .asObservable()
    }
    
    var takePhotoButtonTapped$: Observable<()> {
        return takePictureButton.rx.tap
            .map { _ in () }
            .asObservable()
    }
    
    private(set) var disposeBag = DisposeBag()
    
    private let sceneImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let contentStackView = UIStackView()
    private let buttonsStackView = UIStackView()
    private let containerView = UIView()
    private let navigateButton = ActionButton()
    private let takePictureButton = ActionButton()
    private let gradientView = GradientView()
    private let pinImage = UIImageView()
    private let addressLabel = IconButton()
    private let movieTitleLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bindViewModel(_ viewModel: SceneDetailPagerViewCellViewModel) {
        titleLabel.text = viewModel.scene.title
        descriptionLabel.text = viewModel.description
        
        let icon = UIImage(named: "location_icon_small")
        addressLabel.setTitle(viewModel.location, icon: icon!)
        movieTitleLabel.text = viewModel.movieTitle
        
        sceneImageView.kf.setImage(with: viewModel.imageUrl) {
            image, error, cacheType, imageURL in
            if error != nil {
                self.sceneImageView.image =  viewModel.placeholderImage
            }
        }
        self.gradientView.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

// MARK: - PRIVATE

private extension SceneDetailPagerViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        containerView.layer.cornerRadius = 6.0
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        addSubview(containerView)
        
        let black = UIColor.black.withAlphaComponent(0.8)
        gradientView.colors = (UIColor.clear, black)
        gradientView.isHidden = true
        sceneImageView.insertSubview(gradientView, at: 0)
        
        sceneImageView.contentMode = .scaleAspectFill
        sceneImageView.clipsToBounds = true
        sceneImageView.kf.indicatorType = .activity
        containerView.addSubview(sceneImageView)
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.medium(textStyle: .headline)
        titleLabel.textAlignment = .left
        containerView.addSubview(titleLabel)
        
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.alignment = .leading
        contentStackView.spacing = 4
        containerView.addSubview(contentStackView)

        movieTitleLabel.font = UIFont.regular(textStyle: .subheadline)
        movieTitleLabel.textColor = .black
        contentStackView.addArrangedSubview(movieTitleLabel)
        
        addressLabel.titleLabel?.font = UIFont.light(textStyle: .caption1)
        addressLabel.setTitleColor(.black, for: .normal)
        contentStackView.addArrangedSubview(addressLabel)
        
        descriptionLabel.textColor = .rhinoBlack
        descriptionLabel.font = UIFont.thin(textStyle: .footnote)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        contentStackView.addArrangedSubview(descriptionLabel)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.spacing = 8
        buttonsStackView.alignment = .center
        
        navigateButton.setTitle("Navigate", for: .normal)
        buttonsStackView.addArrangedSubview(navigateButton)
        
        takePictureButton.setTitle("Take Photo", for: .normal)
        buttonsStackView.addArrangedSubview(takePictureButton)
        takePictureButton.isHidden = true
        
        containerView.addSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        
        let margin: CGFloat = 15
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        sceneImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        // Snapkit constraint do not work in this case, used standart instead
        sceneImageView.addConstraint(NSLayoutConstraint(item: sceneImageView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: sceneImageView,
                                                  attribute: .width,
                                                  multiplier: 9.0 / 16.0,
                                                  constant: 0))
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(margin)
            make.bottom.equalTo(sceneImageView).inset(5)
        }
        
        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(sceneImageView)
            make.top.equalTo(titleLabel.snp.top).offset(-10)
        }

        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(sceneImageView.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(margin)
            make.bottom.lessThanOrEqualTo(navigateButton.snp.top).inset(-5)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}

