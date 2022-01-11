//
//  MovieHeaderView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class MovieHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Properties
    
    var goToMap$: Observable<()> {
        return goToMapButton.rx.tap.asObservable()
    }
    
    lazy var photoContainerView = UIView()

    private(set) var disposeBag = DisposeBag()

    private lazy var moviePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.medium(textStyle: .title1) // or bold?
        label.textColor = UIColor(named: "rhinoBlack")
        return label
    }()
    
    private lazy var goToMapButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("Show on map", for: .normal)
        return button
    }()
    
    private var imageViewHeightLayoutConstraint: Constraint?
    private var imageViewBottomLayoutConstraint: Constraint?
    
    // MARK: Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bindViewModel(_ viewModel: MovieHeaderViewModel) {
        moviePhoto.kf.setImage(with: viewModel.imageUrl)
        titleLabel.text = viewModel.title
    }
    
    func updatePosition(withInset inset: CGFloat, contentOffset: CGFloat) {
        let offsetY = -(contentOffset + inset)
        photoContainerView.clipsToBounds = offsetY <= 0
        imageViewBottomLayoutConstraint?.update(offset: offsetY >= 0 ? 0 : -offsetY / 2)
        imageViewHeightLayoutConstraint?.update(offset: max(offsetY + inset, inset))
    }
}

private extension MovieHeaderView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        moviePhoto.kf.indicatorType = .activity
        photoContainerView.addSubview(moviePhoto)
        photoContainerView.clipsToBounds = true
        addSubview(photoContainerView)
        
        moviePhoto.addTopGradient()
    
        addSubview(goToMapButton)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        let padding : CGFloat = Constants.movieDetailViewControllerPadding
        
        photoContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        photoContainerView.addConstraint(NSLayoutConstraint(item: photoContainerView,
                                                             attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: photoContainerView,
                                                             attribute: .width,
                                                             multiplier: 3.0 / 4.0,
                                                             constant: 0))
        
        moviePhoto.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            imageViewBottomLayoutConstraint = make.bottom.equalToSuperview().constraint
            imageViewHeightLayoutConstraint = make.height.equalToSuperview().constraint
        }
        
        goToMapButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(padding)
            make.centerY.equalTo(photoContainerView.snp.bottom)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(goToMapButton.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(padding)
            make.bottom.equalToSuperview()
        }
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
