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

class MovieHeaderView: UIView {
    
    // MARK: Properties
    
    var goToMap$: Observable<()> {
        return mapButton.rx.tap.asObservable()
    }

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
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        stackView.alignment = UIStackViewAlignment.fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("go to map", for: .normal)
        return button
    }()
    
    private lazy var numberofLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private var gradient = CAGradientLayer()
    private lazy var photoContainerView = UIView()

    let viewModel : MovieHeaderViewModel
    
    private var containerHeightLayoutConstraint: Constraint?
    private var imageViewHeightLayoutConstraint: Constraint?
    private var imageViewBottomLayoutConstraint: Constraint?

    // MARK: Init
    
    init(viewModel: MovieHeaderViewModel) {
        self.viewModel = viewModel

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
        bindViewModel()
    }
    
    private func setupViews() {
        backgroundColor = .white

        photoContainerView.addSubview(moviePhoto)
        addSubview(photoContainerView)
        
        photoContainerView.clipsToBounds = true

        addSubview(descriptionLabel)
        addSubview(titleLabel)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(numberofLocationLabel)
        containerStackView.addArrangedSubview(mapButton)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 16
        
        photoContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            containerHeightLayoutConstraint = make.height.equalTo(350).constraint
        }
        
        moviePhoto.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            imageViewBottomLayoutConstraint = make.bottom.equalToSuperview().constraint
            imageViewHeightLayoutConstraint = make.height.equalToSuperview().constraint
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoContainerView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(padding)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func bindViewModel() {
        moviePhoto.image = viewModel.movieImage
        descriptionLabel.text = viewModel.description
        titleLabel.text = viewModel.title
        numberofLocationLabel.text = viewModel.numberOfFilmingLocations
    }
}
