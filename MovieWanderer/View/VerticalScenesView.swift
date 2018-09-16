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
    
    private var scenes = [Place]()
    private let insetValue: CGFloat = 10
    
    private var _scrolledToScene = PublishSubject<Place>()
    var scrolledToScene$: Observable<Place> {
        return _scrolledToScene
    }
    
    let scenesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.register(SceneTableViewCell.self)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(scenes: [Place]) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        self.scenes = scenes
        
        scenesTableView.dataSource = self
        
        addSubview(scenesTableView)
        scenesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scenesTableView.reloadData()        
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setScenes(scenes: [Place]) {
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

