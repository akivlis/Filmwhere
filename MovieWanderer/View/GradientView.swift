//
//  GradientView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 25.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

final class GradientView: UIView {
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var colors: (start: UIColor, end: UIColor)? {
        didSet { updateLayer() }
    }
    
    private func updateLayer() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = colors.map { [$0.start.cgColor, $0.end.cgColor] }
    }
}
