//
//  SceneTableViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class SceneTableViewCell: UITableViewCell {
    
    let sceneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        return imageView
    }()
    
    let descriptionContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .myRed
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    var viewModel: SceneCollectionViewCellViewModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bindViewModel(_ viewModel: SceneCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        distanceLabel.text = "Croatia" //"\(viewModel.distanceFromMe) m away"
        sceneImageView.image = viewModel.sceneImage
    }
}

private extension SceneTableViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(sceneImageView)
        contentView.addSubview(descriptionContainerView)
        
        descriptionContainerView.addSubview(titleLabel)
        descriptionContainerView.addSubview(subtitleLabel)
        descriptionContainerView.addSubview(distanceLabel)
    }
    
    private func setupConstraints() {
        sceneImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(130)
        }
        
        descriptionContainerView.snp.makeConstraints { make in
            make.left.equalTo(sceneImageView.snp.right).offset(8)
            make.top.bottom.equalTo(sceneImageView).inset(4)
            make.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
}
