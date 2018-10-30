//
//  SceneDetailPagerViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 19.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import FSPagerView
import UIKit

class SceneDetailPagerViewCell: FSPagerViewCell {
    
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let containerView = UIView()
    private let actionButton = UIButton()
    private let gradientView = GradientView()

    
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
        backgroundImageView.image = viewModel.image
    }
}

// MARK: - PRIVATE

private extension SceneDetailPagerViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        containerView.layer.cornerRadius = 8.0
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        addSubview(containerView)
        
        let black = UIColor.black.withAlphaComponent(0.8)
        gradientView.colors = (UIColor.clear, black)
        backgroundImageView.insertSubview(gradientView, at: 0)
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.regular(withSize: UIDevice.iPhoneNarrow ? 15 : 18)
        titleLabel.textAlignment = .left
        
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.regular(withSize: UIDevice.iPhoneNarrow ? 14 : 14)
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        
        actionButton.setTitle("Action button", for: .normal)
        actionButton.setTitleColor(.myRed, for: .normal)
        actionButton.backgroundColor = .clear
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = UIColor.myRed.cgColor
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        actionButton.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 24)
        actionButton.layer.cornerRadius = 4
        
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        
        let margin: CGFloat = 15
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        // Snapkit constraint do not work in this case, used standart instead
        backgroundImageView.addConstraint(NSLayoutConstraint(item: backgroundImageView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: backgroundImageView,
                                                  attribute: .width,
                                                  multiplier: 9.0 / 16.0,
                                                  constant: 0))
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(margin)
            make.bottom.equalTo(backgroundImageView).inset(5)
        }
        
        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(backgroundImageView)
            make.top.equalTo(titleLabel.snp.top)//.inset(10)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(margin)
            make.trailing.leading.equalToSuperview().inset(margin)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(subtitleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
    }
}

