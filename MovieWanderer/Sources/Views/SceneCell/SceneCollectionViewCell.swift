//
//  SceneCollectionViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import SkeletonView
import FSPagerView

class SceneCollectionViewCell: FSPagerViewCell {

    private lazy var sceneView = SceneCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(sceneView)
        
        sceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        sceneView.showSkeleton()
        self.contentView.layer.shadowRadius = 0
    }
    
    func bindViewModel(_ viewModel: SceneCellViewModel) {
        sceneView.bindViewModel(viewModel)
        sceneView.hideSkeleton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



