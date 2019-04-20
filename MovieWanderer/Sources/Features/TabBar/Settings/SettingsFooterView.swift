//
//  SettingsFooterView.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 21.04.19.
//  Copyright © 2019 Silvia Kuzmova. All rights reserved.
//

import UIKit

class SettingsFooterView: UITableViewHeaderFooterView {

   lazy var versionLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}
private extension SettingsFooterView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        let background = UIView()
        backgroundView?.backgroundColor = .lightGray
        backgroundView = background

        versionLabel.font = UIFont.medium(textStyle: .footnote)
        versionLabel.textColor = .darkGray
        versionLabel.textAlignment = .center
        
        if let versionNumber = UIApplication.appVersion {
            versionLabel.text = "Version " + versionNumber
        }
        addSubview(versionLabel)
    }
    
    private func setupConstraints() {
        versionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
