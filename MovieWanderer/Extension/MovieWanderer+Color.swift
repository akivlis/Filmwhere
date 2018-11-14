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
    
    public static let lightGray = UIColor.color(fromHexString: "#EDEDED")
    
    public static let appBlue = UIColor.color(fromHexString: "#007FFF")
    
    public static let darkGreen = UIColor.color(fromHexString: "#357F68")

    public static let lightBordo = UIColor.color(fromHexString: "##9f6778")

    public static let darkPink = UIColor.color(fromHexString: "#A85077")

    public static let pink = UIColor.color(fromHexString: "#DD7EB5")

    public static let lightPink = UIColor.color(fromHexString: "#F2D8E5")

    public static let sand = UIColor.color(fromHexString: "##D9C897")
    
    public static let darkBordo = UIColor.color(fromHexString: "#5F021F")
    
    public static let see = UIColor.color(fromHexString: "#D3EBED")
    
    
    
}


public extension UIColor {
    
    
    
    public static func color(fromHexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(colorInteger(fromHexString: fromHexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private static func colorInteger(fromHexString: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: fromHexString)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
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
    
    // credits to @andreaantonioni for this addition
    var isWhiteText: Bool {
        let red = self.redValue * 255
        let green = self.greenValue * 255
        let blue = self.blueValue * 255
        
        // https://en.wikipedia.org/wiki/YIQ
        // https://24ways.org/2010/calculating-color-contrast/
        let yiq = ((red * 299) + (green * 587) + (blue * 114)) / 1000
        return yiq < 192
    }
    
}
