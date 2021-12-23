//
//  TextProvider.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 01.06.19.
//  Copyright © 2019 Silvia Kuzmova. All rights reserved.
//

import UIKit

// MARK: TextProvider

class TextProvider: NSObject, UIActivityItemSource {
    
    private let viewModel : TextProviderViewModel

    init(viewModel: TextProviderViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return NSObject()
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        
        if let activity = activityType {
            return viewModel.textItems(for: activity)
        }
        return nil
    }
}

struct TextProviderViewModel {
    
    let movieTitle: String
    
    func textItems(for activity: UIActivity.ActivityType) -> Any? {
        switch activity {
        case .postToTwitter:
            return "Visiting \(movieTitle) filming locations with @filmwhere"
        case .postToFacebook:
            return "Visiting \(movieTitle) filming locations with #filmwhere"
        default:
            return nil
        }
    }
}

