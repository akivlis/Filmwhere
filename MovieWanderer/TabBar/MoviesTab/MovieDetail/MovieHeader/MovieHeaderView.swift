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
        
        //todo: remove
        self.snp.makeConstraints { make in
            make.height.equalTo(380)
        }
        
        moviePhoto.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
      
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(moviePhoto).offset(-10)
            make.left.equalToSuperview().inset(20)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(moviePhoto.snp.bottom)
        }
        
        mapButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func bindViewModel() {
        
        moviePhoto.image = viewModel.movieImage
        descriptionLabel.text = viewModel.description
        titleLabel.text = viewModel.title
        numberofLocationLabel.text = viewModel.numberOfFilmingLocations
        
        
    }
    
    
    
}
