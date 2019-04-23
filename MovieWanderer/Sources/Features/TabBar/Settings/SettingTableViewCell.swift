//
//  SettingTableViewCell.swift
//  Filmwhere
//
//  Created by Silvia Kuzmova on 21.04.19.
//  Copyright © 2019 Silvia Kuzmova. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    private lazy var titleLabel = UILabel()
    private lazy var iconView = UIImageView()
    private lazy var stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func set(_ title: String, iconName: String) {
        titleLabel.text = title
        iconView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
    }
}

// MARK: - Private

private extension SettingTableViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        separatorInset = UIEdgeInsets(top: 0, left: 61, bottom: 0, right: 0)
        
        stackView.axis = .horizontal
        stackView.spacing = 20
        addSubview(stackView)
        
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .gray
        stackView.addArrangedSubview(iconView)
        
        titleLabel.textColor = .darkText
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
    }
}
