//
//  ActionButton.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 04.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

final class ActionButton: UIButton {

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(colors: [UIColor.brightPink.cgColor, UIColor.lightPink.cgColor])
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage.image(of: color), for: state)
    }
}

private extension ActionButton {
    
    private func commonInit() {
        backgroundColor = .lightGreen
        setTitleColor(.white, for: .normal)
        titleLabel?.font =  UIFont.preferredFont(forTextStyle: .subheadline)
        titleEdgeInsets =  UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        contentEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 24)
    }
   
    private func applyGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
