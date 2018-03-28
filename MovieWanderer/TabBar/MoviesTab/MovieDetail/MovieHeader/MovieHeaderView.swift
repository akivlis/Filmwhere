//
//  MovieHeaderView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MovieHeaderView: UIView {
    
    // MARK: Properties

    lazy var moviePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Lokrum")
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .black
        return label
    }()

    let viewModel : MovieHeaderViewModel

    // MARK: Init
    
    init(viewModel: MovieHeaderViewModel) {
        
        self.viewModel = viewModel

        super.init(frame: .zero)
        backgroundColor = .white
        
        loadSubviews()
        setConstraints()
        bindViewModel()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MovieHeaderView {
    
    func loadSubviews() {
        
        addSubview(moviePhoto)
        addSubview(descriptionLabel)
       
    }
    
    func setConstraints() {
        
        self.autoSetDimension(.height, toSize: 300)
        
        moviePhoto.autoPinEdge(toSuperviewEdge: .top)
        moviePhoto.autoPinEdge(toSuperviewEdge: .left)
        moviePhoto.autoPinEdge(toSuperviewEdge: .right)
        moviePhoto.autoSetDimension(.height, toSize: 200)
        
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: moviePhoto, withOffset: 10)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)

    }
    
    func bindViewModel() {
        
        moviePhoto.image = viewModel.movieImage
        descriptionLabel.text = viewModel.description
        
        
    }
    
    
    
}
