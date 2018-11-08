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
    
    private var _showMapTapped$ = PublishSubject<()>()
    var showMapTapped$: Observable<()>{
        return _showMapTapped$
    }
    
    private let movie: Movie
    private var headerView: MovieHeaderView?
    private var scenes: [Scene]
    private let showHeader: Bool
    
    let scenesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
            
            let width = UIScreen.main.bounds.size.width
            layout.estimatedItemSize = CGSize(width: 400, height: 10)
            
//            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize //CGSize(width: 200, height: 1)
//            layout.itemSize = CGSize(width: 100, height: 100)
//            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            layout.headerReferenceSize = CGSize(width: 50, height: 300)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
//        collectionView.register(nibName: "ExpandableDescriptionCollectionViewCell", cell: ExpandableDescriptionCollectionViewCell.self)
        collectionView.register(ExpandableDescriptionCollectionViewCell.self)
        collectionView.register(header: MovieHeaderView.self)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    init(movie: Movie, showHeader: Bool = true) {
        self.movie = movie // movie should be only in movieHeaderView
        self.showHeader = showHeader
        self.scenes = movie.scenes
        super.init(frame: .zero)
        backgroundColor = .clear

        scenesCollectionView.dataSource = self
        scenesCollectionView.delegate = self
        scenesCollectionView.backgroundColor = .blue
        
        addSubview(scenesCollectionView)
        scenesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setScenes(scenes: [Scene]) {
        self.scenes = scenes
        scenesCollectionView.reloadData()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VerticalScenesView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenes.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpandableDescriptionCollectionViewCell.reuseIdentifier, for: indexPath)
            if let expandableCell = cell as? ExpandableDescriptionCollectionViewCell {
                return expandableCell
            }
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier(for: indexPath), for: indexPath)
//
//        if let chapterCell = cell as? ChapterTableViewCell {
//            if let cellViewModel = viewModel.chapterCellViewModel(indexPath: indexPath) {
//                chapterCell.bindViewModel(viewModel: cellViewModel)
//            }
//        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SceneCollectionViewCell.reuseIdentifier, for: indexPath)
        if let sceneCell = cell as? SceneCollectionViewCell {
            let index = indexPath.row - 1
            let viewModel = SceneCellViewModel(scene: scenes[index])
            sceneCell.bindViewModel(viewModel)
            return sceneCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieHeaderView.reuseIdentifier, for: indexPath)
        if let movieHeader = headerView as? MovieHeaderView {
            movieHeader.bindViewModel(MovieHeaderViewModel(movie: movie))
            self.headerView = movieHeader
            movieHeader.goToMap$
                .subscribe(onNext: { [weak self] in
                    self?._showMapTapped$.onNext(())
                }).disposed(by:movieHeader.disposeBag)
            return movieHeader
        }
        return headerView
    }
}

extension VerticalScenesView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.updatePosition(withInset: scrollView.contentInset.top, contentOffset: scrollView.contentOffset.y)
    }
}

extension VerticalScenesView: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return UICollectionViewFlowLayoutAutomaticSize
//
//        let width = collectionView.bounds.width - 40 //TODO: add variable here to match the margin with the header
//        let height: CGFloat = 180
//        return CGSize(width: width, height: 300)
//    }
}

