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

class MovieHeaderView: UICollectionReusableView {
    
    // MARK: Properties
    
    var goToMap$: Observable<()> {
        return goToMapButton.rx.tap.asObservable()
    }
    
    private(set) var disposeBag = DisposeBag()

    private lazy var moviePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Lokrum")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .myDarkGray
        return label
    }()
    
    private lazy var openMoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .myRed
        label.text = "More"
        return label
    }()
    
    private var gradient = CAGradientLayer()
    private lazy var photoContainerView = UIView()
    private let goToMapButton = UIButton(type: .system)
    private var containerHeightLayoutConstraint: Constraint?
    private var imageViewHeightLayoutConstraint: Constraint?
    private var imageViewBottomLayoutConstraint: Constraint?

    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        descriptionLabel.text = viewModel.description
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
        backgroundColor = .white
    
        photoContainerView.addSubview(moviePhoto)
        photoContainerView.clipsToBounds = true
        addSubview(photoContainerView)
        
        goToMapButton.setTitle("Show on map", for: .normal)
        goToMapButton.tintColor = .white
        goToMapButton.backgroundColor = .myRed
        goToMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        goToMapButton.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        goToMapButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 24)
        goToMapButton.layer.cornerRadius = 4
        addSubview(goToMapButton)

        addSubview(descriptionLabel)
        addSubview(titleLabel)
        addSubview(openMoreLabel)
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
            make.top.equalTo(photoContainerView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(titleLabel)
            make.right.equalTo(goToMapButton)
        }
        
        openMoreLabel.snp.makeConstraints { make in
            make.left.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview().inset(4)
        }
    }
}
