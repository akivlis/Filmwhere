//
//  MovieWanderer+UIApplication.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 21.04.19.
//  Copyright © 2019 Silvia Kuzmova. All rights reserved.
//

import UIKit

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
