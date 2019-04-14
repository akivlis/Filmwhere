//
//  SceneCarouselView.swift
//  MovieWanderer
//
//  Created by Silvika on 22/07/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import FSPagerView

final class SceneCarouselView: UIView {
    
    private var _scrolledToScene$ = PublishSubject<Scene>()
    var scrolledToScene$: Observable<Scene> {
        return _scrolledToScene$
    }
    
    private var _selectSceneCell$ = PublishSubject<Int>()
    var selectSceneCell$: Observable<Int> {
        return _selectSceneCell$
    }
    
    private let lineSpacing: CGFloat = Constants.ScenesCollection.lineSpacing
    private var scenes = [Scene]()
    private let cellWidth: CGFloat = Constants.ScenesCollection.cellWidth
    private let disposeBag = DisposeBag()
    private let scenesCollectionView = FSPagerView()
    
    init(scenes: [Scene]) {
        super.init(frame: .zero)
        self.scenes = scenes
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setScenes(scenes: [Scene]) {
        self.scenes = scenes
        scenesCollectionView.reloadData()
    }
    
    func scrollToIndex(_ index: Int, animated: Bool) {
        scenesCollectionView.selectItem(at: index, animated: animated)
    }
}

extension SceneCarouselView: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        let count = scenes.count
        return count == 0 ? 2 : count
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: SceneCollectionViewCell.reuseIdentifier, at: index)
        if let scalingCell = cell as? SceneCollectionViewCell {
            if scenes.count != 0 {
                let cellViewModel = SceneCellViewModel(scene: scenes[index])
                scalingCell.bindViewModel(cellViewModel)
            }
        }
        return cell
    }
}

extension SceneCarouselView: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard scenes.count > 0 else { return }
        _selectSceneCell$.onNext(index)
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let index = pagerView.currentIndex
        guard scenes.count > 0 else { return }
        
        let selectedScene = scenes[index]
        _scrolledToScene$.onNext(selectedScene)
    }
}

private extension SceneCarouselView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupViews() {
        backgroundColor = .white

        let spacing = CGFloat(10)
        let height = (cellWidth / 16) * 9
        let size = CGSize(width: cellWidth, height: height)
        scenesCollectionView.itemSize = size
        scenesCollectionView.interitemSpacing = spacing
        
//        scenesCollectionView.transformer = FSPagerViewTransformer(type: .linear)
        scenesCollectionView.register(SceneCollectionViewCell.self,
                                      forCellWithReuseIdentifier: SceneCollectionViewCell.reuseIdentifier)
        addSubview(scenesCollectionView)
    }
    
    private func setupConstraints() {
        scenesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.top.equalToSuperview()
        }
    }
    
    private func setupDelegates() {
        scenesCollectionView.delegate = self
        scenesCollectionView.dataSource = self
    }
}
