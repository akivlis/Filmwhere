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


fileprivate let myCollectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 0
    return layout
}()

class SceneListView: UIView {
    
    fileprivate var scenes = [Scene]()
    
    fileprivate let insetValue: CGFloat = 10
    
    
    let scenesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myCollectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.register(SceneCollectionViewCell.self, forCellWithReuseIdentifier: "SceneCollectionViewCell")
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(scenes: [Scene]?) {
        super.init(frame: .zero)
        backgroundColor =  .white //.lightGray
        
        if let scenes = scenes {
            self.scenes = scenes
        }
        
        scenesCollectionView.dataSource = self
        scenesCollectionView.delegate = self
        
        addSubview(scenesCollectionView)

        scenesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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

extension SceneListView: UICollectionViewDataSource {
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

extension SceneListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension SceneListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width - 2 * insetValue

        return CGSize(width: width, height: 250)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: insetValue, bottom: 50, right: insetValue)
    }
    

}


