//
//  SceneCarouselView.swift
//  MovieWanderer
//
//  Created by Silvika on 22/07/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

final class SceneCarouselView: UIView {
    
    private var _scrolledToScene$ = PublishSubject<Scene>()
    var scrolledToScene$: Observable<Scene> {
        return _scrolledToScene$
    }
    
    private var _selectSceneCell$ = PublishSubject<ScenesAndIndex>()
    var selectSceneCell$: Observable<ScenesAndIndex> {
        return _selectSceneCell$
    }
    
    private let lineSpacing: CGFloat = Constants.ScenesCollection.lineSpacing
    private var scenes = [Scene]()
    private let cellWidth: CGFloat = Constants.ScenesCollection.cellWidth
    private let disposeBag = DisposeBag()
    private let movieTitleLabel = UILabel()
    
    private let scenesCollectionView: UICollectionView = {
        let myCollectionViewFlowLayout: LeftAlignedFlowLayout = {
            let layout = LeftAlignedFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = Constants.ScenesCollection.lineSpacing
            layout.minimumInteritemSpacing = 0
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: myCollectionViewFlowLayout)
        return collectionView
    }()
    
    init(scenes: [Scene]) {
        super.init(frame: .zero)
        
        self.scenes = scenes
        movieTitleLabel.text = scenes.first?.movieTitle
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setScenes(scenes: [Scene]) {
        self.scenes = scenes
        movieTitleLabel.text = scenes.first?.movieTitle
        scenesCollectionView.reloadData()
    }
    
    func scrollToIndex(_ index: Int, animated: Bool) {
        let x = index * (Int(cellWidth) + Int(lineSpacing)) //TODO: change
        
        scenesCollectionView.scrollToItem(at: IndexPath(row: index, section: 0),
                                          at: .left,
                                          animated: true)
        print("SETTING CONTENT OFFSET!!!!!")
        movieTitleLabel.text = scenes[index].movieTitle
    }
}

extension SceneCarouselView: UICollectionViewDataSource {

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        let count = scenes.count
        return count == 0 ? 2 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SceneCollectionViewCell.reuseIdentifier, for: indexPath)
        if let scalingCell = cell as? SceneCollectionViewCell {
            if scenes.count != 0 {
                let cellViewModel = SceneCellViewModel(scene: scenes[indexPath.row])
                scalingCell.bindViewModel(cellViewModel)
            }
        }
        return cell
    }
}

extension SceneCarouselView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard scenes.count > 0 else { return }
        _selectSceneCell$.onNext((scenes, indexPath.row))
        movieTitleLabel.text = scenes[indexPath.row].movieTitle
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / (cellWidth + lineSpacing)
        let roundedIndex: Int = Int(abs(index.rounded()))
        
        guard scenes.count > 0 else { return }
        let selectedScene = scenes[roundedIndex]
        _scrolledToScene$.onNext(selectedScene)
        movieTitleLabel.text = selectedScene.movieTitle
    }
}

extension SceneCarouselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    }
}

private extension SceneCarouselView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupViews() {
        backgroundColor = .white

        movieTitleLabel.font = UIFont.regular(textStyle: .body)
        movieTitleLabel.textColor = .lightBlue
        movieTitleLabel.sizeToFit()
        addSubview(movieTitleLabel)
        
        scenesCollectionView.register(SceneCollectionViewCell.self)
        scenesCollectionView.backgroundColor = .clear
        scenesCollectionView.isPagingEnabled = false
        scenesCollectionView.showsHorizontalScrollIndicator = false
        scenesCollectionView.showsVerticalScrollIndicator = false
        scenesCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        scenesCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                         left: Constants.ScenesCollection.lineSpacing,
                                                         bottom: 0,
                                                         right: Constants.ScenesCollection.lineSpacing)
        addSubview(scenesCollectionView)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 5
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.ScenesCollection.lineSpacing)
            make.top.equalToSuperview().inset(padding)
        }
        
        scenesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.ScenesCollection.lineSpacing)
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(padding)
        }
    }
    
    private func setupDelegates() {
        scenesCollectionView.delegate = self
        scenesCollectionView.dataSource = self
    }
}
