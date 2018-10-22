//
//  SceneTableViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class SceneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    private let gradientView = GradientView()
    
    var viewModel: SceneCellViewModel?
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func bindViewModel(_ viewModel: SceneCellViewModel){
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
//        distanceButton.setTitle(viewModel.distanceFromMe, for: .normal)
        backgroundImageView.image = viewModel.sceneImage

    }
}

private extension SceneCollectionViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        backgroundImageView.layer.cornerRadius = 8
        
        gradientView.colors = (UIColor.clear, UIColor.black)
        backgroundImageView.insertSubview(gradientView, at: 0)
    }
    
    private func setupConstraints() {
        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(backgroundImageView)
            make.height.equalTo(80)
        }
    }
}
