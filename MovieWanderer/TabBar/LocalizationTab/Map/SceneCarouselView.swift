//
//  SceneCarouselView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 12.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit
import UPCarouselFlowLayout


fileprivate let myCollectionViewFlowLayout: UPCarouselFlowLayout = {
    let layout = UPCarouselFlowLayout()
    layout.sideItemScale = 1.0
    layout.spacingMode =  UPCarouselFlowLayoutSpacingMode.fixed(spacing: 10)
//        UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 20)
    layout.scrollDirection = .horizontal
    layout.sideItemAlpha = 1.0
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 0
    return layout
}()

class SceneCarouselView: UIView {
    
    fileprivate var scenes = [Scene]()
    fileprivate let insetValue: CGFloat = 10
    
    
    let scenesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myCollectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.register(SceneCollectionViewCell.self, forCellWithReuseIdentifier: "SceneCollectionViewCell")
        
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
        print("tapped")
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        if scrollView == self.scenesCollectionView {
//            var currentCellOffset = self.scenesCollectionView.contentOffset
//            currentCellOffset.x += (self.scenesCollectionView.frame.width - 4 * insetValue) /// 2
//            if let indexPath = self.scenesCollectionView.indexPathForItem(at: currentCellOffset) {
//                self.scenesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            }
//        }
//    }
}

extension SceneCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width - 4 * insetValue
        return CGSize(width: width, height: frame.height - 15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
    }
    
    
}


