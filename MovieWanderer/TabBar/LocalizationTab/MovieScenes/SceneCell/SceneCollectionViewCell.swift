//
//  SceneCollectionViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class SceneCollectionViewCell: UICollectionViewCell {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        loadSubviews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(_ viewModel: SceneCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
//        subtitleLabel.text = viewModel.subtitle
        distanceLabel.text = "\(viewModel.distanceFromMe) m away"
        sceneImageView.image = viewModel.sceneImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        shadowAndRound()
    }
    
    func shadowAndRound() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 4.0
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true

        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
        //if we want to have shadow on each side, we set the shadowOffset to CGSize.zero and set shadowPath
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8.0).cgPath
    }
}

private extension SceneCollectionViewCell {
    
    private func loadSubviews() {
        contentView.addSubview(sceneImageView)
        contentView.addSubview(descriptionContainerView)
        
        descriptionContainerView.addSubview(titleLabel)
        descriptionContainerView.addSubview(subtitleLabel)
        descriptionContainerView.addSubview(distanceLabel)
    }
    
    private func setConstraints() {
        sceneImageView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(170)
//            make.height.equalTo(contentView).multipliedBy(2/3)
        }
        
        descriptionContainerView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(sceneImageView.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(sceneImageView)
            make.top.equalToSuperview().inset(8)
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
