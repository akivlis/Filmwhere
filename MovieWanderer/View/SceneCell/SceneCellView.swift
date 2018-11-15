//
//  SceneCellView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 09.11.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import Kingfisher

class SceneCellView: UIView {
    
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let gradientView = GradientView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bindViewModel(_ viewModel: SceneCellViewModel){
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
        
        backgroundImageView.kf.setImage(with: viewModel.imageUrl) {
            image, error, cacheType, imageURL in
            if error != nil {
                self.backgroundImageView.image =  viewModel.placeholderImage
            }
        }
    }
}

private extension SceneCellView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 8
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        
        let blackColor = UIColor.black.withAlphaComponent(0.9)
        gradientView.colors = (UIColor.clear, blackColor)
        backgroundImageView.insertSubview(gradientView, at: 0)

        titleLabel.textColor = .white
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.textColor = .white
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        addSubview(stackView)
        
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // Snapkit constraint do not work in this case, used standart instead
        let aspectRatioConstraint = NSLayoutConstraint(item: backgroundImageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: backgroundImageView,
                                                       attribute: .width,
                                                       multiplier: 9.0 / 21.0,
                                                       constant: 0)
        aspectRatioConstraint.priority = .defaultHigh
        backgroundImageView.addConstraint(aspectRatioConstraint)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(backgroundImageView)
            make.height.equalTo(80)
        }
    }
}
