//
//  InfoSceneCollectionViewCell.swift
//  MovieWanderer
//
//  Created by Silvika on 22/07/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class InfoSceneCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView()
    let sceneImageView = UIImageView()
    let descriptionLabel = UILabel()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bindViewModel(_ viewModel: SceneCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
//                descriptionLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description
        sceneImageView.image = viewModel.sceneImage
    }
}

private extension InfoSceneCollectionViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        sceneImageView.contentMode = .scaleAspectFill
        sceneImageView.clipsToBounds = true
        sceneImageView.layer.cornerRadius = 4.0
        containerView.addSubview(sceneImageView)
        
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        containerView.addSubview(descriptionLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        containerView.addSubview(titleLabel)
        
        contentView.addSubview(containerView)
        containerView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        let padding : CGFloat = 8
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sceneImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(padding)
            make.width.equalTo(160)
            make.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sceneImageView)
            make.left.equalTo(sceneImageView.snp.right).offset(padding)
            make.right.equalToSuperview().inset(padding)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(padding)
            make.left.right.equalTo(titleLabel)
        }
    }
}
