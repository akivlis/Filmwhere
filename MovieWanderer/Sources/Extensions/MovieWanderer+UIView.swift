//
//  MovieWanderer+UIView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit

let gradientViewTag: Int = 1

extension UIView {
    
    // NOTE: Be aware where you call this! A good place to do it is layoutSubviews, because you need the frame so you can't do it in viewDidLoad.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if corners == .allCorners {
            layer.masksToBounds = true
            layer.cornerRadius = radius
        } else {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func addTopGradient() {
        let height = UIApplication.shared.keyWindow!.safeAreaInsets.top + 60

         let topGradient : GradientView = {
            let gradient = GradientView()
            gradient.tag = gradientViewTag
            gradient.colors = (UIColor.black.withAlphaComponent(0.5), .clear)
            gradient.isUserInteractionEnabled = false
            return gradient
        }()
        
        addSubview(topGradient)
        
        topGradient.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(height)
        }
        bringSubviewToFront(topGradient)
    }
    
    func removeTopGradient() {
        if let gradientView = self.subviews.first as? GradientView {
            gradientView.removeFromSuperview()
        }
    }
    
    func hideTopGradient() {
        if let gradientView = self.viewWithTag(gradientViewTag) as? GradientView {
            gradientView.isHidden = true
        }
    }
    
    func showTopGradient() {
        if let gradientView = self.viewWithTag(gradientViewTag) as? GradientView {
            gradientView.isHidden = false
        }
    }
    
}

extension CALayer {
    func addShadow() {
        self.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.shadowOpacity = 0.2
        self.shadowRadius = 6.0
        self.shadowColor = UIColor.gray.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first
//                sublayer.name == Constants.contentLayerName
            {
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
//            contentLayer.name = Constants.contentLayerName
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
}

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UILabel {
    func isTruncated() -> Bool {
        guard let labelText = text else {
            return false
        }
        
        self.layoutIfNeeded()
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}
