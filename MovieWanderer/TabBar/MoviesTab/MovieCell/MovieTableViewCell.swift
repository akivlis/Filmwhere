//
//  MovieCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import Kingfisher
import SkeletonView

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfScenesLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        setupViews()
        showSkeleton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        movieImageView.layer.cornerRadius  = 8.0
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
 
        roundView.layer.addShadow()
    }
    
    func bindViewModel(_ viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        numberOfScenesLabel.text = viewModel.numberOfScenes

//        numberOfScenesLabel.set(image: UIImage(named: "projector")!, with: viewModel.numberOfScenes)
        
        movieImageView.kf.setImage(with: viewModel.imageUrl) {
            image, error, cacheType, imageURL in
            if error != nil {
                self.movieImageView.image =  viewModel.placeholderImage
            }
        }
        
        hideSkeleton()
    }
}

private extension MovieTableViewCell {
    
    private func setupViews() {
        roundView.layer.cornerRadius = 8.0
        movieImageView.kf.indicatorType = .activity
        
        numberOfScenesLabel.textColor = .darkGreen
    }
    
    private func showSkeleton() {
        movieImageView.showAnimatedGradientSkeleton()
        titleLabel.showAnimatedGradientSkeleton()
        subtitleLabel.showAnimatedGradientSkeleton()
        numberOfScenesLabel.showAnimatedGradientSkeleton()
    }
    
    private func hideSkeleton() {
        movieImageView.hideSkeleton()
        titleLabel.hideSkeleton()
        subtitleLabel.hideSkeleton()
        numberOfScenesLabel.hideSkeleton()
    }
}
