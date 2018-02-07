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
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    let descriptionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
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
    
    func bindViewModel(viewModel: SceneCollectionViewCellViewModel){
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        distanceLabel.text = "\(viewModel.distanceFromMe) m away"
        
    }
    
    
}

fileprivate extension SceneCollectionViewCell {
    
    func loadSubviews() {
        addSubview(sceneImageView)
        addSubview(descriptionContainerView)
        
        descriptionContainerView.addSubview(titleLabel)
        descriptionContainerView.addSubview(subtitleLabel)
        descriptionContainerView.addSubview(distanceLabel)
    }
    
    func setConstraints() {
        
        sceneImageView.autoPinEdge(toSuperviewEdge: .top)
        sceneImageView.autoPinEdge(toSuperviewEdge: .right)
        sceneImageView.autoPinEdge(toSuperviewEdge: .left)
        sceneImageView.autoSetDimension(.height, toSize: 200)
        
        descriptionContainerView.autoPinEdge(toSuperviewEdge: .bottom)
        descriptionContainerView.autoPinEdge(toSuperviewEdge: .left)
        descriptionContainerView.autoPinEdge(toSuperviewEdge: .right)
        descriptionContainerView.autoPinEdge(.top, to: .bottom, of: sceneImageView)
        
        
        titleLabel.autoPinEdge(toSuperviewMargin: .left)
        titleLabel.autoPinEdge(toSuperviewMargin: .top)
        
        subtitleLabel.autoPinEdge(toSuperviewMargin: .left)
        subtitleLabel.autoPinEdge(toSuperviewMargin: .bottom)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        
        distanceLabel.autoPinEdge(toSuperviewMargin: .right)
        distanceLabel.autoPinEdge(toSuperviewMargin: .top)

        
        
    }

    
}
