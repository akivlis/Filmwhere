//
//  SceneCarouselView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 12.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import CenteredCollectionView


fileprivate let myCollectionViewFlowLayout: CenteredCollectionViewFlowLayout = {
    let layout = CenteredCollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 0
    return layout
}()

class SceneCarouselView: UIView {
    
    fileprivate var scenes = [Scene]()
    fileprivate let insetValue: CGFloat = 10
    
    
    fileprivate var _scrolledToScene = PublishSubject<Scene>()
    var scrolledToScene$: Observable<Scene> {
        return _scrolledToScene
    }
    
    
    let scenesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myCollectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.register(SceneCollectionViewCell.self, forCellWithReuseIdentifier: "SceneCollectionViewCell")
//        collectionView.isPagingEnabled = true
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(scenes: [Scene]) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        self.scenes = scenes
        
        scenesCollectionView.dataSource = self
        scenesCollectionView.delegate = self
        
        addSubview(scenesCollectionView)
        scenesCollectionView.autoPinEdgesToSuperviewEdges()
        scenesCollectionView.reloadData()
        
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setScenes(scenes: [Scene]) {
        self.scenes = scenes
        scenesCollectionView.reloadData()
    }
}

extension SceneCarouselView: UICollectionViewDataSource {
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return scenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SceneCollectionViewCell", for: indexPath) as! SceneCollectionViewCell
        let viewModel = SceneCollectionViewCellViewModel(scene: scenes[indexPath.row])
        cell.bindViewModel(viewModel)
        
        
        return cell
    }
}

extension SceneCarouselView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedScene = scenes[indexPath.row]
//        _scrolledToScene.onNext(selectedScene)
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / (scenesCollectionView.frame.width - 4 * insetValue)
        
        print("index: \(abs(index.rounded()))")
        let roundedIndex: Int = Int(abs(index.rounded()))
        
        let selectedScene = scenes[roundedIndex]
                _scrolledToScene.onNext(selectedScene)

    }
    
    
}

extension SceneCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width - 4 * insetValue
        print(width)
        return CGSize(width: width, height: frame.height - 15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
    }
    
    
}


