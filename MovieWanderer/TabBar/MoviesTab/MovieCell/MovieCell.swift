//
//  MovieCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    fileprivate let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    var viewModel: MovieCellViewModel? {
        didSet {
            customizeCell()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setConstraints()
        
        backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}

fileprivate extension MovieCell {
    
    func customizeCell() {
        
        titleLabel.text = viewModel?.title
        subtitleLabel.text = viewModel?.subtitle
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setConstraints() {
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        
        subtitleLabel.autoPinEdge(toSuperviewEdge: .bottom)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .left)
    }
}
