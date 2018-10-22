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
        
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.clipsToBounds = true
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.bold(withSize: UIDevice.iPhoneNarrow ? 18 : 24)
        titleLabel.textAlignment = .left
        
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.regular(withSize: UIDevice.iPhoneNarrow ? 14 : 18)
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        
        actionButton.setTitle("Action button", for: .normal)
        actionButton.backgroundColor = .red
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        stackView.addArrangedSubview(backgroundImageView)
//        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(actionButton)

        
        containerView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        backgroundImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        backgroundImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
}

