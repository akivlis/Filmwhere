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
        return actionButton.rx.tap
            .map { _ in () }
        .asObservable()
    }
    
    private(set) var disposeBag = DisposeBag()
    
    private let sceneImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let contentStackView = UIStackView()
    private let containerView = UIView()
    private let actionButton = ActionButton()
    private let gradientView = GradientView()
    private let pinImage = UIImageView()
    private let addressLabel = UILabel()
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
        subtitleLabel.text = viewModel.description
        addressLabel.text = viewModel.location
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
        titleLabel.font = UIFont.regular(textStyle: .headline)
        titleLabel.textAlignment = .left
        containerView.addSubview(titleLabel)
        
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.alignment = .leading
        contentStackView.spacing = 4
        containerView.addSubview(contentStackView)

        movieTitleLabel.font = UIFont.regular(textStyle: .subheadline)
        movieTitleLabel.textColor = UIColor.rhinoBlack
        contentStackView.addArrangedSubview(movieTitleLabel)
        
        addressLabel.font = UIFont.light(textStyle: .footnote)
        addressLabel.textColor = UIColor.rhinoBlack
        contentStackView.addArrangedSubview(addressLabel)
        
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.thin(textStyle: .footnote)
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        contentStackView.addArrangedSubview(subtitleLabel)
        
        actionButton.setTitle("Navigate", for: .normal)
        
        containerView.addSubview(actionButton)
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
            make.bottom.lessThanOrEqualTo(actionButton.snp.top).inset(-5)
        }
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}

