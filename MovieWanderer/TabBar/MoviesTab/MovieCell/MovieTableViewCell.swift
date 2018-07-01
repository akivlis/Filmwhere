//
//  MovieCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 21)
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let locationsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let mapIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "movie-icon")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(_ viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        movieImageView.image = UIImage(named: viewModel.imageName)
        locationsLabel.text = "7 locations"  // •   12 km from you" //TODO change
        
        let color = UIColor.myRed
        locationsLabel.textColor = color
        mapIcon.tintColor = color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        movieImageView.layer.addShadow()
    }
}

private extension MovieTableViewCell {
    
    private func setupSubviews() {
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(containerView)
        addSubview(subtitleLabel)
        
        containerView.addSubview(mapIcon)
        containerView.addSubview(locationsLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 16
        
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(padding)
            make.left.right.equalToSuperview().inset(padding)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(movieImageView) //check
            make.top.equalTo(movieImageView.snp.bottom).offset(padding)
            make.height.equalTo(20)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel)//.inset(2)
            make.right.equalToSuperview().inset(padding)
            make.height.equalTo(15)
        }
        
        mapIcon.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(15)
        }
        
        locationsLabel.snp.makeConstraints { make in
            make.left.equalTo(mapIcon.snp.right).offset(10)
            make.top.bottom.right.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(containerView)
            make.top.equalTo(containerView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        
     
    }
}
