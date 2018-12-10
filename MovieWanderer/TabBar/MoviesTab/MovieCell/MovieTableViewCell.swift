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
    @IBOutlet weak var numberButton: UIButton!
    
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
        
        movieImageView.layer.cornerRadius  = 4.0
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundView.layer.addShadow()
        numberButton.layer.cornerRadius = numberButton.bounds.height / 2 // 4
    }
    
    func bindViewModel(_ viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        numberButton.setTitle(viewModel.numberOfScenes, for: .normal)        
        
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
        movieImageView.image = nil
        roundView.layer.cornerRadius = 4.0
        movieImageView.kf.indicatorType = .activity
        
        titleLabel.font = UIFont.bold(textStyle: .title2)
        subtitleLabel.font = UIFont.thin(textStyle: .subheadline)
    }
    
    private func showSkeleton() {
        movieImageView.showAnimatedGradientSkeleton()
        titleLabel.showAnimatedGradientSkeleton()
        subtitleLabel.showAnimatedGradientSkeleton()
        numberButton.isHidden = true
    }
    
    private func hideSkeleton() {
        movieImageView.hideSkeleton()
        titleLabel.hideSkeleton()
        subtitleLabel.hideSkeleton()
        numberButton.isHidden = false
    }
}
