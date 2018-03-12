//
//  SceneCarouselView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 12.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit

fileprivate let myCollectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
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
        collectionView.isPagingEnabled = true
        
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
        cell.bindViewModel(viewModel: viewModel)
        
        //        cell.roundCorners(.allCorners, radius: 3)
        
        return cell
    }
}

extension SceneCarouselView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension SceneCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 2 * insetValue
        
        return CGSize(width: width, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: insetValue, bottom: 50, right: insetValue)
    }
    
    
}


