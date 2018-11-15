//
//  MovieWanderer+Font.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 19.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

fileprivate enum FontWeight: String {
    case ultralight = "UltraLight"
    case light = "Light"
    case regular = "Regular"
    case semibold = "SemiBold"
    case bold = "Bold"
    case ultrabold = "UltraBold"
    case heavy = "Heavy"
    
    fileprivate func toSystemWeight() -> UIFont.Weight {
        switch self {
        case .ultralight:
            return UIFont.Weight.ultraLight
        case .light:
            return UIFont.Weight.light
        case .regular:
            return UIFont.Weight.regular
        case .semibold:
            return UIFont.Weight.semibold
        case .bold:
            return UIFont.Weight.bold
        case .ultrabold, .heavy:
            return UIFont.Weight.heavy
        }
    }
}

extension UIFont {
    
    static func ultralight(withSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(withSize: size, weight: .ultralight, isItalic: isItalic)
    }
    
    static func light(withSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(withSize: size, weight: .light, isItalic: isItalic)
    }
    
    static func regular(withSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(withSize: size, weight: .regular, isItalic: isItalic)
    }
    
    static func semibold(withSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(withSize: size, weight: .semibold, isItalic: isItalic)
    }
    
    static func bold(withSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(withSize: size, weight: .bold, isItalic: isItalic)
    }
    
    static func ultrabold(withSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(withSize: size, weight: .ultrabold, isItalic: isItalic)
    }
    
    static func heavy(withSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(withSize: size, weight: .heavy, isItalic: isItalic)
    }
    
    static func circularBold(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: "CircularStd-Bold", size: size)
    }
}

extension UIFont {
    
    // MARK: Definition
    
    fileprivate static func customFont(withSize size: CGFloat, weight: FontWeight, isItalic: Bool = false) -> UIFont {
        let italic = isItalic ? "It" : ""
        let fontName = "FibraOne-\(weight.rawValue)\(italic)"
        
        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size, weight: weight.toSystemWeight())
        }
        return font
    }
}

extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
}
