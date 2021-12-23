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

final class SceneDetailViewController: BaseCloseViewController {
    
    private let pagerView = FSPagerView()
    private let blurredView = UIVisualEffectView()
    private let scenes: [Scene]
    private let currentIndex: Int
    private let titleLabel = UILabel()
    private let navigationModelController: MapNavigationModelController
    
    init(scenes: [Scene], currentIndex: Int, title: String, navigationModelController: MapNavigationModelController) {
        self.scenes = scenes
        self.currentIndex = currentIndex
        self.titleLabel.text = title
        self.navigationModelController = navigationModelController
        super.init(dismissOnPullDown: true)
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

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension SceneDetailViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return scenes.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: SceneDetailPagerViewCell.reuseIdentifier, at: index)
        if let sceneCell = cell as? SceneDetailPagerViewCell {
            let currentScene = scenes[index]
            let viewModel = SceneDetailPagerViewCellViewModel(scene: currentScene)
            sceneCell.bindViewModel(viewModel)
            
            sceneCell.scenePhotoTapped$
                .subscribe(onNext: { [weak self] optionalImage in
                    if let image = optionalImage {
                        self?.open(images: [image])
                    }
                })
                .disposed(by: sceneCell.disposeBag)
            
            sceneCell.navigateButtonTapped$
                .subscribe(onNext: { [weak self] _ in
                    //TODO: check if the current scene is correct
                    self?.navigationModelController.openMapsFor(currentScene)
                })
            .disposed(by: sceneCell.disposeBag)
            
            sceneCell.takePhotoButtonTapped$
                .subscribe(onNext: { [weak self] tuple in
                    guard let `self` = self, let scenePhoto = tuple.sceneImage else { return }
                    self.takePhoto(like: scenePhoto, movieTitle: tuple.movieTitle)
                })
                .disposed(by: sceneCell.disposeBag)
        }
        return cell
    }
}

extension SceneDetailViewController: FSPagerViewDelegate {
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let index = pagerView.currentIndex
        self.titleLabel.text = scenes[index].movieTitle
    }
}

private extension SceneDetailViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
        
        pagerView.dataSource = self
        pagerView.delegate = self
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
            make.height.width.equalTo(30)
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
        
        navigationModelController.presentMapsActionSheet$
            .subscribe(onNext: { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func open(images: [UIImage]) {
        let pictureViewController = PictureViewController(pictures: images)
        pictureViewController.modalPresentationStyle = .overCurrentContext
        self.present(pictureViewController, animated: true, completion: nil)
    }
    
    private func takePhoto(like scenePhoto: UIImage, movieTitle: String) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraViewController = TakePhotoViewController(sceneImage: scenePhoto, movieTitle: movieTitle)
            self.present(cameraViewController, animated: true, completion: nil)
        }
    }
}

