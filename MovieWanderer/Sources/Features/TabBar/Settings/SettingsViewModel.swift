//
//  SettingsViewModel.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 20.04.19.
//  Copyright © 2019 Silvia Kuzmova. All rights reserved.
//

import Foundation
import RxSwift

class SettingsViewModel {
    
    let bag = DisposeBag()
    
    var openURL$: Observable<URL> {
        return openURL
    }
    private let openURL = PublishSubject<URL>()
    

    var numberOfRows: Int {
        return SetttinsRow.allCases.count
    }
    
    func getRowFor(index: Int) -> SetttinsRow {
        return SetttinsRow(rawValue: index)!
    }
    
    func bind(cellTapped: Observable<IndexPath>) {
        cellTapped
            .map { $0.row }
            .subscribe(onNext: { [unowned self] index in
                let tappedRow = SetttinsRow(rawValue: index)!
                self.handleTapOn(row: tappedRow)
            })
            .disposed(by: bag)
    }
}

private extension SettingsViewModel {
    private func handleTapOn(row: SetttinsRow) {
        guard let url = URL(string: row.urlAddress) else { return }
        openURL.onNext(url)
    }
}


enum SetttinsRow: Int, CaseIterable {
    case privacyPolicy, sendFeedback
    
    var title: String {
        switch self {
        case .privacyPolicy:
            return "Privacy Policy"
        case .sendFeedback:
            return "Feedback"
        }
    }
    
    var iconName: String {
        switch self {
        case .privacyPolicy:
            return "icon_privacy"
        case .sendFeedback:
            return "icon_feedback"
        }
    }
    
    var urlAddress: String {
        switch self {
        case .privacyPolicy:
            return NetworkConstants.privacyPolicy
        case .sendFeedback:
            let email = NetworkConstants.emailAddress
            let subject = "Feedback"
            let body = ""
            let urlString = "mailto:\(email)?subject=\(subject)&body=\(body)"
            return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
    }
}
