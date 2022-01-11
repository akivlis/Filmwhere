//
//  MovieWanderer+UIDevice.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 19.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

@objc enum DeviceType: Int {
    case iPhone4S = 0, iPhoneSE, iPhone7, iPhone7Plus, iPadRegular, iPadPro, unknown
}

extension UIDevice {
    
    static var iPad: Bool {
        return current.userInterfaceIdiom == .pad
    }
    
    static var iPadRegular: Bool {
        return iPad && ((portrait && UIScreen.main.bounds.size.height == 1024) || (landscape && UIScreen.main.bounds.size.width == 1024))
    }
    
    static var iPadPro: Bool {
        return iPad && ((portrait && UIScreen.main.bounds.size.height == 1366) || (landscape && UIScreen.main.bounds.size.width == 1366))
    }
    
    static var iPhone: Bool {
        return current.userInterfaceIdiom == .phone
    }
    
    static var iPhone4S: Bool {
        return iPhone && UIScreen.main.bounds.size.height == 480
    }
    
    static var iPhoneNarrow: Bool {
        return iPhone && UIScreen.main.bounds.size.width == 320
    }
    
    static var iPhoneSE: Bool {
        return iPhone && UIScreen.main.bounds.size.height == 568
    }
    
    static var iPhone7: Bool {
        return iPhone && UIScreen.main.bounds.size.height == 667
    }
    
    static var iPhone7Plus: Bool {
        return iPhone && UIScreen.main.bounds.size.height == 736
    }
    
    static var iPhoneX: Bool {
        return iPhone && UIScreen.main.nativeBounds.height == 2436
    }
    
    static var landscape: Bool {
        return UIApplication.shared.connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first?
            .windowScene?
            .interfaceOrientation
            .isLandscape ?? false
    }
    
    static var portrait: Bool {
        return UIApplication.shared.connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first?
            .windowScene?
            .interfaceOrientation
            .isPortrait ?? false
    }
}
