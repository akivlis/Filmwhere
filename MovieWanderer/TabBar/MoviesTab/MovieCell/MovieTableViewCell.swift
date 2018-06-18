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
        movieImageView.roundCorners(.allCorners, radius: 4)
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
        
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2 * padding)
            make.left.right.equalToSuperview().inset(padding)
            make.height.equalTo(230)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(movieImageView) //check
            make.top.equalTo(movieImageView.snp.bottom).offset(12)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        locationsLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(2 * padding)
        }
    }
}
