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
    
    private let topGradient : GradientView = {
        let gradient = GradientView()
        gradient.colors = (UIColor.black.withAlphaComponent(0.7), .clear)
        return gradient
    }()
    
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
        }
        return cell
    }
}

extension SceneDetailViewController : FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let pictureViewController = PictureViewController(dismissOnPullDown: true)
        pictureViewController.modalPresentationStyle = .overCurrentContext
        self.present(pictureViewController, animated: true, completion: nil)
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
        
        let blurEffect = UIBlurEffect(style: .light)
        blurredView.effect = blurEffect
        view.addSubview(blurredView)
        
        view.addSubview(topGradient)
        
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
        topGradient.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(80)
        }
        
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
}
