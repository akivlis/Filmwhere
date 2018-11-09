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
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .myDarkGray
        return label
    }()
    
    private lazy var goToMapButton: UIButton = {
        let goToMapButton =   UIButton(type: .system)
        goToMapButton.setTitle("Show on map", for: .normal)
        goToMapButton.tintColor = .white
        goToMapButton.backgroundColor = .myRed
        goToMapButton.titleLabel?.font =  UIFont.preferredFont(forTextStyle: .subheadline)
        goToMapButton.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        goToMapButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 24)
        goToMapButton.layer.cornerRadius = 4
        return goToMapButton
    }()
    
    private var gradient = CAGradientLayer()
    private lazy var photoContainerView = UIView()
    
    private var didSetConstraints = false
    private var containerHeightLayoutConstraint: Constraint?
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = moviePhoto.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bindViewModel(_ viewModel: MovieHeaderViewModel) {
        moviePhoto.kf.setImage(with: viewModel.imageUrl) {
            image, error, cacheType, imageURL in
            if error != nil {
                self.moviePhoto.image =  viewModel.placeholderImage
            }
        }
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
        photoContainerView.addSubview(moviePhoto)
        photoContainerView.clipsToBounds = true
        addSubview(photoContainerView)
    
        addSubview(goToMapButton)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        
        photoContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        photoContainerView.addConstraint(NSLayoutConstraint(item: photoContainerView,
                                                             attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: photoContainerView,
                                                             attribute: .width,
                                                             multiplier: 9.0 / 16.0,
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
            make.top.equalTo(goToMapButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
