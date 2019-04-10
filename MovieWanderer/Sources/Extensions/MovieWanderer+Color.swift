//
//  MovieWanderer+Color.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    static let lightGray = UIColor.color(fromHexString: "#EDEDED")
    
    static let lightBlue = UIColor.color(fromHexString: "#248CDC")
    
    static let lemonGreen = UIColor.color(fromHexString: "#C0DF85")

    static let lightOrange = UIColor.color(fromHexString: "#DEB986")

    static let lightPink = UIColor.color(fromHexString: "#EC6881")
    
    static let brightPink = UIColor.color(fromHexString: "#EA4059")

    static let veryBrightPink = UIColor.color(fromHexString: "#FF1C4D")
    
    static let see = UIColor.color(fromHexString: "#D3EBED")
    
    static let rhinoBlack = UIColor.color(fromHexString: "#282E36")
}

public extension UIColor {
    
    static func color(fromHexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        let hexint = Int(colorInteger(fromHexString: fromHexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private static func colorInteger(fromHexString: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: fromHexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    var redValue: CGFloat{
        return cgColor.components! [0]
    }
    
    var greenValue: CGFloat{
        return cgColor.components! [1]
    }
    
    var blueValue: CGFloat{
        return cgColor.components! [2]
    }
    
    var alphaValue: CGFloat{
        return cgColor.components! [3]
    }
    
}
