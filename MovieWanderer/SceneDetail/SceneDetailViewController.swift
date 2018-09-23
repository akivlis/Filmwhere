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
    private let pageControl = FSPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        
        closeButton.rx.tap.subscribe(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}

extension SceneDetailViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 5
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: SceneDetailPagerViewCell.reuseIdentifier, at: index)
        if let sceneCell = cell as? SceneDetailPagerViewCell {
            sceneCell.titleLabel.text = "Page \(index)"
            sceneCell.subtitleLabel.text = "hflsfls  fslfls"
            sceneCell.backgroundImageView.image = UIImage(named: "Jamie")
        }
        return cell
    }
}

extension SceneDetailViewController: FSPagerViewDelegate {
    
//    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
//        pageControl.currentPage = pagerView.currentIndex
//    }
//
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let page = pagerView.currentIndex
        pageControl.currentPage = page
    }
    
}

private extension SceneDetailViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        
        pagerView.dataSource = self
        pagerView.delegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.veryLightPink
        
        pagerView.register(SceneDetailPagerViewCell.self, forCellWithReuseIdentifier: SceneDetailPagerViewCell.reuseIdentifier)
        pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
//        pagerView.backgroundColor = .blue
        view.addSubview(pagerView)
        
        if let image = UIImage(named: "close-icon") {
            closeButton.setImage(image, for: .normal)
        }
        view.addSubview(closeButton)
        
        pageControl.numberOfPages = 5
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(.gray, for: .normal)
        pageControl.setFillColor(.myRed, for: .selected)
        view.addSubview(pageControl)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.height.width.equalTo(25)
        }
        
        pagerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(60)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pagerView.snp.bottom).offset(10)
            make.left.right.equalTo(pagerView)
        }
    }
}
