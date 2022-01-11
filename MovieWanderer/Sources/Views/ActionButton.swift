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
        self.init(configuration: UIButton.Configuration.filled(), primaryAction: nil)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(colors: [
            UIColor(named: "brightPink")!.cgColor,
            UIColor(named: "lightPink")!.cgColor
        ])
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage.image(of: color), for: state)
    }
}

private extension ActionButton {
    
    private func commonInit() {
        backgroundColor = UIColor(named: "brightPink")
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.systemBackground.withAlphaComponent(0.5), for: .highlighted)
        titleLabel?.font =  UIFont.medium(textStyle: .subheadline)
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
