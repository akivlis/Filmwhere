//
//  IconButton.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

final class IconButton: UIButton {

    // MARK: Init
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init() {
        self.init(type: .custom)
        commonInit()
    }
    
    public func setTitle(_ title: String, icon: UIImage) {
        setTitle(title, for: .normal)
        setImage(icon, for: .normal)
    }
}

private extension IconButton {
    
    private func commonInit() {
        isUserInteractionEnabled = false
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.font =  UIFont.medium(textStyle: .subheadline)
    }
}
