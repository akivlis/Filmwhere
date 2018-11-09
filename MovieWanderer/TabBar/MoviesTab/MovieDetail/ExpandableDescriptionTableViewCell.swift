//
//  ExpandableDescriptionTableViewCell.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 08.11.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

fileprivate enum CellState {
    case collapsed
    case expanded
    
    var buttonTitle: String {
        switch self {
        case .collapsed:
            return "More"
        case .expanded:
            return "Less"
        }
    }
    
    var numberOfLines: Int {
        switch self {
        case .collapsed:
            return 3
        case .expanded:
            return 0
        }
    }
    
}

class ExpandableDescriptionTableViewCell: UITableViewCell {
    
    private(set) var disposeBag = DisposeBag()
    
    private var state: CellState = .collapsed {
        didSet {
            toggle()
        }
    }
    
    private var _reloadCell$ = PublishSubject<()>()
    var reloadCell$: Observable<()>{
        return _reloadCell$
    }
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
        label.contentMode = .top
        return label
    }()
    
    private lazy var openMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.myRed, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        // want to set openMoreButton only once, cause then there is a strange animation when expanding/closing
//        if !didSetConstraints {
//            openMoreButton.isHidden = !descriptionLabel.isTruncated() //&& !isDescriptionExtended
//        }
//        didSetConstraints = true

//        let padding : CGFloat = 20
//        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame,
//                                                  UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: Public
    
    func setDescription(_ description: String) {
        descriptionLabel.text = description
    }
}

private extension ExpandableDescriptionTableViewCell {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        self.descriptionLabel.numberOfLines = self.state.numberOfLines
        self.openMoreButton.setTitle(self.state.buttonTitle, for: .normal)
        
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        openMoreButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(openMoreButton)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(4)
        }
    }
    
    private func setupObservables() {
        openMoreButton.rx.tap
            .subscribe(onNext: { _ in
                self.state = self.state == .collapsed ? .expanded : .collapsed
            })
        //            .disposed(by: disposeBag)
    }
    
    private func toggle() {
        self.descriptionLabel.numberOfLines = self.state.numberOfLines
        self.openMoreButton.setTitle(self.state.buttonTitle, for: .normal)
        self._reloadCell$.onNext(())
    }
}
