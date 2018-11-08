//
//  ExpandableDescriptionCollectionViewCell.swift
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

class ExpandableDescriptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var state: CellState = .collapsed {
        didSet {
            toggle()
        }
    }
    
    private var disposeBag = DisposeBag()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLabel.sizeToFit()
        
        
        
        moreButton.rx.tap
            .subscribe(onNext: { _ in
                self.state = self.state == .collapsed ? .expanded : .collapsed
            })
            .disposed(by: disposeBag)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        subtitleLabel.text = "Liz Gilbert (Julia Roberts) thought she had everything she wanted in life: a home, a husband and a successful career. Now newly divorced and facing a turning point, she finds that she is confused about what is important to her. Daring to step out of her comfort zone, Liz embarks on a quest of self-discovery that takes her to Italy, India and Bali."
        backgroundColor = .green
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(openMoreButton)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
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
        UIView.animate(withDuration: 0.25) {
            self.descriptionLabel.numberOfLines = self.state.numberOfLines
            self.moreButton.setTitle(self.state.buttonTitle, for: .normal)
            self.layoutIfNeeded()
        }
    }

}
