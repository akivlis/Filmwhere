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
    
    private(set) var disposeBag = DisposeBag()
    
    private let sceneImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let containerView = UIView()
    private let actionButton = UIButton()
    private let gradientView = GradientView()
    private let addressStackView = UIStackView()
    private let pinImage = UIImageView()
    private let addressLabel = UILabel()
    
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
        
        sceneImageView.kf.setImage(with: viewModel.imageUrl) {
            image, error, cacheType, imageURL in
            if error != nil {
                self.sceneImageView.image =  viewModel.placeholderImage
                self.gradientView.isHidden = false
            }
        }
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
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.regular(withSize: UIDevice.iPhoneNarrow ? 15 : 18)
        titleLabel.textAlignment = .left
        
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.regular(withSize: UIDevice.iPhoneNarrow ? 14 : 14)
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        
        actionButton.setTitle("Action button", for: .normal)
        actionButton.setTitleColor(.darkGreen, for: .normal)
        actionButton.backgroundColor = .clear
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = UIColor.darkGreen.cgColor
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        actionButton.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 24)
        actionButton.layer.cornerRadius = 4
        
        containerView.addSubview(sceneImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(addressStackView)
        containerView.addSubview(subtitleLabel)
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
                                                  multiplier: 3.0 / 4.0,
                                                  constant: 0))
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(margin)
            make.bottom.equalTo(sceneImageView).inset(5)
        }
        
        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(sceneImageView)
            make.top.equalTo(titleLabel.snp.top)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sceneImageView.snp.bottom).offset(margin)
            make.trailing.leading.equalToSuperview().inset(margin)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(subtitleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
    }
}

