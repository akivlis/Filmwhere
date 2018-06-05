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

    private lazy var moviePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Lokrum")
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("go to map", for: .normal)
        return button
    }()
    
    private lazy var numberofLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
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
        addSubview(titleLabel)
        
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(numberofLocationLabel)
        containerStackView.addArrangedSubview(mapButton)

       
    }
    
    func setConstraints() {
        
        self.autoSetDimension(.height, toSize: 380)

        moviePhoto.autoPinEdge(toSuperviewEdge: .top)
        moviePhoto.autoPinEdge(toSuperviewEdge: .left)
        moviePhoto.autoPinEdge(toSuperviewEdge: .right)
        moviePhoto.autoSetDimension(.height, toSize: 250)
        
        titleLabel.autoPinEdge(.bottom, to: .bottom, of: moviePhoto, withOffset: -10)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        containerStackView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        containerStackView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        containerStackView.autoPinEdge(.top, to: .bottom, of: moviePhoto)
        
        mapButton.autoSetDimensions(to: CGSize(width: 60, height: 60))
        
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: containerStackView, withOffset: 10)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)

    }
    
    func bindViewModel() {
        
        moviePhoto.image = viewModel.movieImage
        descriptionLabel.text = viewModel.description
        titleLabel.text = viewModel.title
        numberofLocationLabel.text = viewModel.numberOfFilmingLocations
        
        
    }
    
    
    
}
