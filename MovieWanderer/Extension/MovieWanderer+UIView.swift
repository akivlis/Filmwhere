//
//  MovieWanderer+UIView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // NOTE: Be aware where you call this! A good place to do it is layoutSubviews, because you need the frame so you can't do it in viewDidLoad.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if corners == .allCorners {
            layer.masksToBounds = true
            layer.cornerRadius = radius
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
}

extension CALayer {
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 0.5
        self.shadowRadius = 8.0
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        self.shadowOffset = CGSize(width: 5.0, height: 5.0)
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

extension UILabel {
    func set(image: UIImage, with text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentStr)
        
        let textString = NSAttributedString(string: text, attributes: [.font: self.font])
        mutableAttributedString.append(textString)
        
        self.attributedText = mutableAttributedString
    }
}

