//
//  MovieWanderer+UIAlertController.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 01.06.19.
//  Copyright © 2019 Silvia Kuzmova. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func createAlertController(withTitle title: String?,
                                      message: String?,
                                      closeActionTitle: String) -> UIAlertController {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: closeActionTitle,
                                        style: .default,
                                        handler: nil))
        return alertVC
    }
}
