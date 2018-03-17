//
//  MovieWanderer+PureLayout.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//


import PureLayout
import UIKit
import Foundation

extension UIView {
    

    @discardableResult
    @available(iOS 11.0, *)
    func autoPinToSafeAreaOfView(_ edge: ALEdge, of view: UIView, withInset normalInset: CGFloat = 0, insetForDeviceWithNotch notchInset: CGFloat? = nil) -> NSLayoutConstraint? {
        
        let inset = UIDevice.iPhoneX ? (notchInset ?? normalInset) : normalInset
        
        switch edge {
        case .top:
            let constraint = topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: inset
            )
            constraint.isActive = true
            return constraint
        case .bottom:
            let constraint = bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -inset
            )
            constraint.isActive = true
            return constraint
        default:
            break
        }
        
        return nil
    }
    
    @discardableResult
    func autoPinToSafeArea(_ edge: ALEdge, of controller: UIViewController, withInset normalInset: CGFloat = 0, insetForDeviceWithNotch notchInset: CGFloat? = nil) -> NSLayoutConstraint? {
        
        switch edge {
        case .top:
            if #available(iOS 11.0, *) {
                return autoPinToSafeAreaOfView(.top, of: controller.view, withInset: normalInset, insetForDeviceWithNotch: notchInset)
            } else {
                return autoPin(toTopLayoutGuideOf: controller, withInset: CGFloat(normalInset))
            }
        case .bottom:
            if #available(iOS 11.0, *) {
                return autoPinToSafeAreaOfView(.bottom, of: controller.view, withInset: normalInset, insetForDeviceWithNotch: notchInset)
            } else {
                return autoPin(toBottomLayoutGuideOf: controller, withInset: CGFloat(normalInset))
            }
        default:
            break
        }
        
        return nil
    }
}


extension UIDevice {
//    var iPhoneX: Bool {
//        return UIScreen.main.nativeBounds.height == 2436
//    }
    
    static var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
}

