//
//  SceneTableViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 09.11.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

final class SceneTableViewCell: UITableViewCell {

    private lazy var sceneView = SceneCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(sceneView)
        
        sceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding : CGFloat = Constants.movieDetailViewControllerPadding
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 10, right: padding))
    }
    
    func bindViewModel(_ viewModel: SceneCellViewModel) {
        sceneView.bindViewModel(viewModel)
    }
}
