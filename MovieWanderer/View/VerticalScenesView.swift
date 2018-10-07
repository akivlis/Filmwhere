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
    
    let scenesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = true
        tableView.register(UINib(nibName: "SceneTableViewCell", bundle: nil), forCellReuseIdentifier: SceneTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(scenes: [Scene]) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        self.scenes = scenes
        
        scenesTableView.dataSource = self
        scenesTableView.delegate = self
        
        addSubview(scenesTableView)
        scenesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scenesTableView.reloadData()        
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setScenes(scenes: [Scene]) {
        self.scenes = scenes
        scenesTableView.reloadData()
    }
}

extension VerticalScenesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SceneTableViewCell.reuseIdentifier, for: indexPath) as! SceneTableViewCell
        let viewModel = SceneCellViewModel(scene: scenes[indexPath.row])
        cell.bindViewModel(viewModel)
        
        return cell
    }
}

extension VerticalScenesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

