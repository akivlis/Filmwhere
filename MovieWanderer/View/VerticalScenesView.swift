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
    
    private let movie: Movie
    private var _showMapTapped$ = PublishSubject<()>()
    var showMapTapped$: Observable<()>{
        return _showMapTapped$
    }
    
    private var headerView: MovieHeaderView?
    
    let scenesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(UINib(nibName: "SceneCell", bundle: nil), forCellWithReuseIdentifier: SceneCollectionViewCell.reuseIdentifier)
        collectionView.register(header: MovieHeaderView.self)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(frame: .zero)

        backgroundColor = .clear
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
}

extension VerticalScenesView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.scenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SceneCollectionViewCell.reuseIdentifier, for: indexPath)
        if let sceneCell = cell as? SceneCollectionViewCell {
            
            let viewModel = SceneCellViewModel(scene: movie.scenes[indexPath.row])
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40 //TODO: add variable here to match the margin with the header
        let height: CGFloat = 180
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 350
        
        return CGSize(width: width, height: height)
    }
}

