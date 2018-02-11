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
            layer.masksToBounds = false
            layer.cornerRadius = radius
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

//extension UITableViewCell {
//    override func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
//        contentView.roundCorners(corners, radius: radius)
//    }
//}

