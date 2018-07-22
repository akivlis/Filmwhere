//
//  InfoSceneCollectionViewCell.swift
//  MovieWanderer
//
//  Created by Silvika on 22/07/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class InfoSceneCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

private extension InfoSceneCollectionViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        backgroundColor = .red
        
    }
    
    private func setupConstraints() {
        
    }
}
