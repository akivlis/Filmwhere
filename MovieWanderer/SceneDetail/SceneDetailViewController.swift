//
//  SceneDetailViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 19.09.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import FSPagerView

final class SceneDetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let closeButton = UIButton(type: UIButton.ButtonType.system)
    private let pagerView = FSPagerView()
    private let blurredView = UIVisualEffectView()
    private let scenes: [Scene]
    private let currentIndex: Int
    private let titleLabel = UILabel()
    
    init(scenes: [Scene], currentIndex: Int, title: String) {
        self.scenes = scenes
        self.currentIndex = currentIndex
        self.titleLabel.text = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.pagerView.scrollToItem(at: self.currentIndex, animated: false)
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension SceneDetailViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return scenes.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: SceneDetailPagerViewCell.reuseIdentifier, at: index)
        if let sceneCell = cell as? SceneDetailPagerViewCell {
            let viewModel = SceneDetailPagerViewCellViewModel(scene: scenes[index])
            sceneCell.bindViewModel(viewModel)
            
            sceneCell.scenePhotoTapped$
                .subscribe(onNext: { optionalImage in
                    if let image = optionalImage {
                        self.open(images: [image])
                    }
                })
                .disposed(by: sceneCell.disposeBag)
        }
        return cell
    }
}

private extension SceneDetailViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
        
        pagerView.dataSource = self
    }
    
    private func setupViews() {
        modalPresentationCapturesStatusBarAppearance = true
        
        let blurEffect = UIBlurEffect(style: .dark)
        blurredView.effect = blurEffect
        view.addSubview(blurredView)
        
        view.addTopGradient()
        
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        
        pagerView.backgroundColor = .clear
        pagerView.register(SceneDetailPagerViewCell.self, forCellWithReuseIdentifier: SceneDetailPagerViewCell.reuseIdentifier)
        view.addSubview(pagerView)
        pagerView.interitemSpacing = 10
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - 40
        let newWidth = width - 60
        let newHeight = (height / width) * newWidth
        let size = CGSize(width: newWidth, height: newHeight) //TODO: change
        
        pagerView.itemSize = size
        
        if let image = UIImage(named: "close-icon")?.withRenderingMode(.alwaysTemplate) {
            closeButton.setImage(image, for: .normal)
        }
        closeButton.tintColor = .white
        closeButton.imageEdgeInsets =  UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.leading.equalToSuperview().inset(15)
            make.height.width.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.centerX.equalToSuperview()
        }
        
        pagerView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
        }
        
        blurredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupObservables() {
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    private func open(images: [UIImage]) {
        let pictureViewController = PictureViewController(pictures: images)
        pictureViewController.modalPresentationStyle = .overCurrentContext
        self.present(pictureViewController, animated: true, completion: nil)
    }
}
