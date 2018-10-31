//
//  MovieCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let mapIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "movie-icon")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        movieImageView.layer.cornerRadius  = 8.0
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func bindViewModel(_ viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        movieImageView.image = UIImage(named: viewModel.imageName)
    }
}

private extension MovieTableViewCell {
    
    private func setupViews() {
        roundView.layer.cornerRadius = 8.0
    }
}
