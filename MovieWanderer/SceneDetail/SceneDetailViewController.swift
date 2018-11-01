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
    private let closeButton = UIButton(type: UIButtonType.system)
    private let pagerView = FSPagerView()
    private let blurredView = UIVisualEffectView()
    private let scenes: [Scene]
    private let currentIndex: Int
    
    init(scenes: [Scene], currentIndex: Int) {
        self.scenes = scenes
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        
        closeButton.rx.tap.subscribe(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.pagerView.scrollToItem(at: self.currentIndex, animated: false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.bounds.width / 2
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

private extension SceneDetailViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        
        pagerView.dataSource = self
    }
    
    private func setupViews() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurredView.effect = blurEffect
        view.addSubview(blurredView)
        
        pagerView.backgroundColor = .clear
        pagerView.register(SceneDetailPagerViewCell.self, forCellWithReuseIdentifier: SceneDetailPagerViewCell.reuseIdentifier)
        view.addSubview(pagerView)
        pagerView.interitemSpacing = 10
        
        let width = UIScreen.main.bounds.width - 60
        let size = CGSize(width: width, height: 570) //TODO: change
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
            make.centerY.equalTo(pagerView.snp.top)
            make.left.equalToSuperview().inset(15)
            make.height.width.equalTo(25)
        }
        
//        pagerView.backgroundColor = .red
        
        pagerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview()//.inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
        
        blurredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
