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
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let locationsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
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
        
        locationsLabel.text = "Locations: 7" //TODO change
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.roundCorners(.allCorners, radius: 8)
    }
    
}

private extension MovieTableViewCell {
    
    private func setupSubviews() {
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(locationsLabel)
    }
    
    private func setupConstraints() {
        
        let padding: CGFloat = 8
        
        movieImageView.autoPinEdge(toSuperviewEdge: .top, withInset: padding)
        movieImageView.autoPinEdge(toSuperviewEdge: .left, withInset: padding)
        movieImageView.autoPinEdge(toSuperviewEdge: .right, withInset: padding)
        movieImageView.autoSetDimension(.height, toSize: 230)
        
        titleLabel.autoPinEdge(.left, to: .left, of: movieImageView)
        titleLabel.autoPinEdge(.right, to: .right, of: movieImageView)
        titleLabel.autoPinEdge(.top, to: .bottom, of: movieImageView, withOffset: 12)
        
        subtitleLabel.autoPinEdge(.left, to: .left, of: titleLabel)
        subtitleLabel.autoPinEdge(.right, to: .right, of: titleLabel)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 8)

        locationsLabel.autoPinEdge(.left, to: .left, of: titleLabel)
        locationsLabel.autoPinEdge(.right, to: .right, of: titleLabel)
        locationsLabel.autoPinEdge(.top, to: .bottom, of: subtitleLabel, withOffset: 8)
        locationsLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2 * padding)
    }
}
