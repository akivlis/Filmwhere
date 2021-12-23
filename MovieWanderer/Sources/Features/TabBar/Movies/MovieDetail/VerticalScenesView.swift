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
    
    private var showMapTapped = PublishSubject<()>()
    var showMapTapped$: Observable<()>{
        return showMapTapped
    }
    
    private var _updateStatusBarStyle$ = BehaviorSubject<UIStatusBarStyle>(value: .lightContent)
    var updateStatusBarStyle$ : Observable<UIStatusBarStyle> {
        return _updateStatusBarStyle$
            .distinctUntilChanged()
    }
    
    private var _updateNavigationBarAlpha$ = PublishSubject<CGFloat>()
    var updateNavigationBarAlpha$: Observable<CGFloat>{
        return _updateNavigationBarAlpha$
            .distinctUntilChanged()
    }
    
    private let movie: Movie
    private var headerView: MovieHeaderView?
    private var scenes: [Scene]
    private let showHeader: Bool
    private lazy var navigationBarHeight: CGFloat = {
        return UIApplication.shared.keyWindow!.safeAreaInsets.top + 44
    }()
    
    let scenesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsHorizontalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ExpandableDescriptionTableViewCell.self)
        tableView.register(SceneTableViewCell.self)
        tableView.register(headerFooter: MovieHeaderView.self)
        return tableView
    }()
    
    init(movie: Movie, showHeader: Bool = true) {
        self.movie = movie // movie should be only in movieHeaderView
        self.showHeader = showHeader
        self.scenes = movie.scenes
        super.init(frame: .zero)
        backgroundColor = .clear

        scenesTableView.dataSource = self
        scenesTableView.delegate = self
        
        addSubview(scenesTableView)
        scenesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setScenes(scenes: [Scene]) {
        self.scenes = scenes
        scenesTableView.reloadData()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VerticalScenesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableDescriptionTableViewCell.reuseIdentifier, for: indexPath)
            if let expandableCell = cell as? ExpandableDescriptionTableViewCell {
                expandableCell.setDescription(movie.description)
                expandableCell.reloadCell$
                    .subscribe(onNext: { _ in
                            tableView.beginUpdates()
                            tableView.endUpdates()
                    }).disposed(by: expandableCell.disposeBag)
                return expandableCell
            }
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: SceneTableViewCell.reuseIdentifier, for: indexPath)
        if let sceneCell = cell as? SceneTableViewCell {
            let index = indexPath.row - 1
            let viewModel = SceneCellViewModel(scene: scenes[index])
            sceneCell.bindViewModel(viewModel)
            return sceneCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieHeaderView.reuseIdentifier)
        if let movieHeader = headerView as? MovieHeaderView {
            movieHeader.bindViewModel(MovieHeaderViewModel(movie: movie))
            self.headerView = movieHeader
            
            movieHeader.goToMap$
            .bind(to: showMapTapped)
            .disposed(by: movieHeader.disposeBag)
            
            return movieHeader
        }
        return headerView
    }
}

extension VerticalScenesView: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.updatePosition(withInset: scrollView.contentInset.top, contentOffset: scrollView.contentOffset.y)

        let offset = scrollView.contentOffset
        
        let start: CGFloat = navigationBarHeight
        let imageHeight = headerView?.photoContainerView.frame.height ?? 250
        let fullAlphaPoint: CGFloat =  imageHeight - start - navigationBarHeight - start // kolko musim scrollnut + (vyska imagu - start - navigation bar - cast co je skryta)
        let calculatedAlpha = max(min((offset.y - start) / (start + fullAlphaPoint), 1), 0)
        
        _updateNavigationBarAlpha$.onNext(calculatedAlpha)
        
        if calculatedAlpha > 0.7 {
            _updateStatusBarStyle$.onNext(.default)
        } else {
            _updateStatusBarStyle$.onNext(.lightContent)
        }
    }
    

    public func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 90
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 280
    }
}



