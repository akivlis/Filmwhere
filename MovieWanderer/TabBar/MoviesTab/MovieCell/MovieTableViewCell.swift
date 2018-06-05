//
//  MovieCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
        
        backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(_ viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
   }

private extension MovieTableViewCell {

   private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    private func setupConstraints() {
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        
        subtitleLabel.autoPinEdge(toSuperviewEdge: .bottom)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .left)
    }
}
