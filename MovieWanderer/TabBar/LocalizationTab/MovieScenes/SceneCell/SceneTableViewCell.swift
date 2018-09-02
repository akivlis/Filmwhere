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
        label.textColor = .myDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    let distanceButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitleColor(.myRed, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.myRed.cgColor
        button.layer.cornerRadius = 4
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 24)
        return button
    }()
    
    var viewModel: SceneCellViewModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bindViewModel(_ viewModel: SceneCellViewModel){
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        addressLabel.text = viewModel.address
        distanceButton.setTitle(viewModel.distanceFromMe, for: .normal)
        sceneImageView.image = viewModel.sceneImage
    }
}

private extension SceneTableViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        contentView.addSubview(sceneImageView)
        contentView.addSubview(descriptionContainerView)
        
        descriptionContainerView.addSubview(titleLabel)
        descriptionContainerView.addSubview(descriptionLabel)
        descriptionContainerView.addSubview(addressLabel)
        descriptionContainerView.addSubview(distanceButton)
    }
    
    private func setupConstraints() {
        sceneImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(20)
            make.height.width.equalTo(100)
        }
        
        descriptionContainerView.snp.makeConstraints { make in
            make.left.equalTo(sceneImageView.snp.right).offset(20)
            make.top.bottom.equalTo(sceneImageView)//.inset(4)
            make.right.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(2)
        }
        
        distanceButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(2)
        }
    }
}
