//
//  SceneView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 07/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


fileprivate let collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.itemSize = CGSize(width: 300, height: 300)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    return layout
}()

class SceneView: UIView {
    
    private(set) var disposeBag = DisposeBag()
    fileprivate var scenes = [Scene]()
    
    
    let scenesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.bounces = true
        
        collectionView.register(SceneCollectionViewCell.self, forCellWithReuseIdentifier: "SceneCollectionViewCell")
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(scenes: [Scene]?) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        if let scenes = scenes {
            self.scenes = scenes
        }
        
        scenesCollectionView.dataSource = self
        
        addSubview(scenesCollectionView)
        scenesCollectionView.autoPinEdgesToSuperviewEdges()
        
        
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScenes(scenes: [Scene]) {
        self.scenes = scenes
        scenesCollectionView.reloadData()
    }
}

extension SceneView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return scenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SceneCollectionViewCell", for: indexPath) as! SceneCollectionViewCell
        let viewModel = SceneCollectionViewCellViewModel(scene: scenes[indexPath.row])
        cell.bindViewModel(viewModel: viewModel)
        return cell
    }
}

extension SceneView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
    

}


