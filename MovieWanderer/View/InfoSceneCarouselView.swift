//
//  InfoSceneCarouselView.swift
//  MovieWanderer
//
//  Created by Silvika on 22/07/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

class InfoSceneCarouselView: UIView {
    
    var scrolledToScene$: Observable<Scene> {
        return _scrolledToScene$
    }
    
    private var scenes = [Scene]()
    private let cellWidth: CGFloat = 320
    private let disposeBag = DisposeBag()
    private var _scrolledToScene$ = PublishSubject<Scene>()
    
    private let scenesCollectionView: UICollectionView = {
        let myCollectionViewFlowLayout: LeftAlignedFlowLayout = {
            let layout = LeftAlignedFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myCollectionViewFlowLayout)
        return collectionView
    }()
    
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
}

extension InfoSceneCarouselView: UICollectionViewDataSource {

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return scenes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoSceneCollectionViewCell.reuseIdentifier, for: indexPath)
        if let scalingCell = cell as? InfoSceneCollectionViewCell {
            let cellViewModel = SceneCollectionViewCellViewModel(scene: scenes[indexPath.row])
            scalingCell.bindViewModel(cellViewModel)
        }
        return cell
    }
}

extension InfoSceneCarouselView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedScene = scenes[indexPath.row]
        _scrolledToScene$.onNext(selectedScene)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / (cellWidth + 20)
                let roundedIndex: Int = Int(abs(index.rounded()))
        
        let selectedScene = scenes[roundedIndex]
        _scrolledToScene$.onNext(selectedScene)
    }
}


extension InfoSceneCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: frame.height)
    }
}

private extension InfoSceneCarouselView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        scenesCollectionView.register(InfoSceneCollectionViewCell.self)
        scenesCollectionView.backgroundColor = .clear
        scenesCollectionView.isPagingEnabled = false
        scenesCollectionView.decelerationRate  =  UIScrollViewDecelerationRateFast
        scenesCollectionView.showsHorizontalScrollIndicator = false
        
        addSubview(scenesCollectionView)
    }
    
    private func setupConstraints() {
        scenesCollectionView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
        }
    }
    
    private func setupDelegates() {
        scenesCollectionView.delegate = self
        scenesCollectionView.dataSource = self
    }
}
