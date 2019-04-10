//
//  MovieWanderer+Font.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 19.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

fileprivate enum FontWeight: String {
    case light = "-Light"
    case medium = "-Medium"
    case regular = ""
    case thin = "-Thin"
    case ultralight = "-UltraLight"
    case bold = "-Bold"
    case condensedBlack = "-CondensedBlack"
    case condensedBold = "-CondensedBold"
    
    fileprivate func toSystemWeight() -> UIFont.Weight {
        switch self {
        case .ultralight:
            return UIFont.Weight.ultraLight
        case .light:
            return UIFont.Weight.light
        case .regular:
            return UIFont.Weight.regular
        case .bold:
            return UIFont.Weight.bold
        default:
            return UIFont.Weight.regular
        }
    }
}

extension UIFont {
    static func light(textStyle style: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(forTextStyle: style, weight: .light, isItalic: isItalic)
    }
    
    static func medium(textStyle style: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(forTextStyle: style, weight: .medium, isItalic: isItalic)
    }
    
    static func regular(textStyle style: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(forTextStyle: style, weight: .regular, isItalic: isItalic)
    }
    
    static func thin(textStyle style: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(forTextStyle: style, weight: .thin, isItalic: isItalic)
    }
    
    static func ultralight(textStyle style: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(forTextStyle: style, weight: .ultralight, isItalic: isItalic)
    }
    
    static func bold(textStyle style: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(forTextStyle: style, weight: .bold, isItalic: isItalic)
    }
    
    static func condensedBold(textStyle style: UIFont.TextStyle, isItalic: Bool = false) -> UIFont {
        return UIFont.customFont(forTextStyle: style, weight: .condensedBold, isItalic: isItalic)
    }
}

extension UIFont {
    
    // MARK: Definition
    
    fileprivate static func customFont(withSize size: CGFloat, weight: FontWeight, isItalic: Bool = false) -> UIFont {
        let italic = isItalic ? "Italic" : ""
        let fontName = "HelveticaNeue\(weight.rawValue)\(italic)"

        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size, weight: weight.toSystemWeight())
        }
        return font
    }
    
    fileprivate static func customFont(forTextStyle textStyle: UIFont.TextStyle, weight: FontWeight = .regular, isItalic: Bool = false) -> UIFont {
        let italic = isItalic ? "Italic" : ""
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        let fontName = "HelveticaNeue\(weight.rawValue)\(italic)"
        
//        let families = UIFont.familyNames
//        families.sorted().forEach {
//            print("\($0)")
//            let names = UIFont.fontNames(forFamilyName: $0)
//            print(names)
//        }
//
        let fontSize = textStyle.size
        
        guard let font = UIFont(name: fontName, size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize, weight: weight.toSystemWeight())
        }
        return fontMetrics.scaledFont(for: font)
    }
}

extension UIFont.TextStyle {
    
    var size: CGFloat {
        switch self {
        case .largeTitle:
            return 34
        case .title1:
            return 28
        case  .title2 :
            return 22
        case .title3:
            return 20
        case .headline:
            return 17.0
        case .subheadline:
            return 15
        case .body:
            return 17
        case .callout:
            return 16
        case .footnote:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        default:
            return 12
        }
    }
}

