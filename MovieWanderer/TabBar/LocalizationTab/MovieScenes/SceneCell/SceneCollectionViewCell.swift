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
        return imageView
    }()
    
    let descriptionContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .appBlue
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    
    
    var viewModel: SceneCollectionViewCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        loadSubviews()
        setConstraints()
        
        backgroundColor = .clear
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(_ viewModel: SceneCollectionViewCellViewModel){
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        distanceLabel.text = "\(viewModel.distanceFromMe) m away"
        sceneImageView.image = viewModel.sceneImage
        
    }
    
    override func layoutSubviews() {
        shadowAndRound()
    }
    
    func shadowAndRound() {
        
        self.contentView.backgroundColor = .white
        
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true

        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
        //if we want to have shadow on each side, we set the shadowOffset to CGSize.zero and set shadowPath
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8.0).cgPath
    }
    
}

fileprivate extension SceneCollectionViewCell {
    
    func loadSubviews() {
        
        contentView.addSubview(sceneImageView)
        contentView.addSubview(descriptionContainerView)
        
        descriptionContainerView.addSubview(titleLabel)
        descriptionContainerView.addSubview(subtitleLabel)
        descriptionContainerView.addSubview(distanceLabel)
    }
    
    func setConstraints() {
        
        contentView.autoPinEdgesToSuperviewEdges()
        
        sceneImageView.autoPinEdge(toSuperviewEdge: .top)
        sceneImageView.autoPinEdge(toSuperviewEdge: .right)
        sceneImageView.autoPinEdge(toSuperviewEdge: .left)
        sceneImageView.autoMatch(.height, to: .height, of: contentView, withMultiplier: 2/3)
        
        descriptionContainerView.autoPinEdge(toSuperviewEdge: .bottom)
        descriptionContainerView.autoPinEdge(toSuperviewEdge: .left)
        descriptionContainerView.autoPinEdge(toSuperviewEdge: .right)
        descriptionContainerView.autoPinEdge(.top, to: .bottom, of: sceneImageView)
        
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        titleLabel.autoPinEdge(toSuperviewMargin: .top)
        
        subtitleLabel.autoPinEdge(.left, to: .left, of: titleLabel)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 8)

        distanceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        distanceLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
    }

    
}
