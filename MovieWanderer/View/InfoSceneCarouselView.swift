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
    
    private var scenes = [Scene]()
    private let insetValue: CGFloat = 0
    private let disposeBag = DisposeBag()
    
    private let scenesCollectionView: UICollectionView = {
        let myCollectionViewFlowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
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

private extension InfoSceneCarouselView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        scenesCollectionView.register(InfoSceneCollectionViewCell.self)
        scenesCollectionView.backgroundColor = .white
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}


extension InfoSceneCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 40 //4 * insetValue
        return CGSize(width: width, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
