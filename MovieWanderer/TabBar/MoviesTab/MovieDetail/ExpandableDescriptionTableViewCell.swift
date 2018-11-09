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
        label.numberOfLines = 3
        label.sizeToFit()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
        label.contentMode = .top
        return label
    }()
    
    private lazy var openMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More", for: .normal)
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        descriptionLabel.text = "Liz Gilbert (Julia Roberts) thought she had everything she wanted in life: a home, a husband and a successful career. Now newly divorced and facing a turning point, she finds that she is confused about what is important to her. Daring to step out of her comfort zone, Liz embarks on a quest of self-discovery that takes her to Italy, India and Bali."
//        backgroundColor = .green
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(openMoreButton)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        openMoreButton.rx.tap
            .subscribe(onNext: { _ in
                self.state = self.state == .collapsed ? .expanded : .collapsed
            })
//            .disposed(by: disposeBag)

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
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func toggle() {
            self.descriptionLabel.numberOfLines = self.state.numberOfLines
            self.openMoreButton.setTitle(self.state.buttonTitle, for: .normal)
            self._reloadCell$.onNext(())
    }
}
