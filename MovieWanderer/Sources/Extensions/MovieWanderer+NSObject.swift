//
//  MovieWanderer+NSObject.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 28.05.19.
//  Copyright © 2019 Silvia Kuzmova. All rights reserved.
//

import Foundation

extension NSObject {
    static func className() -> String {
        guard let last = NSStringFromClass(self).split(separator: ".").last else {
            return NSStringFromClass(self)
        }
        return String(last)
    }
}
