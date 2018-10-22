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
        subtitleLabel.text = viewModel.scene.description
        backgroundImageView.image = UIImage(named: "Jamie")
    }
}

// MARK: - PRIVATE

private extension SceneDetailPagerViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.layer.shadowRadius = 0
        contentView.layer.shadowColor = UIColor.clear.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        
        containerView.layer.cornerRadius = 8.0
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        addSubview(containerView)
        
        backgroundImageView.contentMode = .scaleAspectFit
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.bold(withSize: UIDevice.iPhoneNarrow ? 18 : 24)
        titleLabel.textAlignment = .center
        
        subtitleLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        subtitleLabel.font = UIFont.regular(withSize: UIDevice.iPhoneNarrow ? 14 : 18)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(backgroundImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        containerView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}

