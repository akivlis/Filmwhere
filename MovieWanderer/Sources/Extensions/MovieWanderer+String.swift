//
//  MovieWanderer+String.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 15.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation

// MARK: - Helpers

 extension String {
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func isValidEmail() -> Bool {
        if count == 0 {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        if count >= 6 {
            return true
        }
        return false
    }
}
