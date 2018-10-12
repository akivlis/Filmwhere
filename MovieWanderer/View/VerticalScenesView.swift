//
//  VerticalScenesView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 12.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class VerticalScenesView: UIView {
    
    private var scenes = [Scene]()
    private var _scrolledToScene = PublishSubject<Scene>()
    var scrolledToScene$: Observable<Scene> {
        return _scrolledToScene
    }
    
    let scenesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
//        collectionView.isScrollEnabled = true
        collectionView.register(UINib(nibName: "SceneCell", bundle: nil), forCellWithReuseIdentifier: SceneCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    init(scenes: [Scene]) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        self.scenes = scenes
        
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

extension VerticalScenesView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SceneCollectionViewCell.reuseIdentifier, for: indexPath)
        if let sceneCell = cell as? SceneCollectionViewCell {
            
            let viewModel = SceneCellViewModel(scene: scenes[indexPath.row])
            sceneCell.bindViewModel(viewModel)
            return sceneCell
        }
        return cell
    }
}

extension VerticalScenesView: UICollectionViewDelegate {
    
}

extension VerticalScenesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 180
        
        return CGSize(width: width, height: height)
    }
}

