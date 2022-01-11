//
//  AnimatingBarView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 30.10.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class AnimatingBarView: UIView {
    
    private let border = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setColorWith(alpha: CGFloat) {
        backgroundColor = UIColor.systemBackground.withAlphaComponent(alpha)
        if alpha == 1.0 {
            border.backgroundColor = UIColor.lightGray
        } else {
            border.backgroundColor = .clear
        }
    }
}

private extension AnimatingBarView {
    
    private func setupViews() {
        backgroundColor = .clear
        
        border.backgroundColor = .clear
        addSubview(border)

        border.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
    

