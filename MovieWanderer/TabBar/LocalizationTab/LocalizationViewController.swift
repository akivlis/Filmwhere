//
//  SceneListViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class LocalizationViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let mapView: MapAndScenesCarouselView
    let searchBar = UISearchBar()
    let viewModel : LocalizationViewModel
    let movieModelController: MoviesModelController
    
    init(moviesModelController: MoviesModelController) {
        self.viewModel = LocalizationViewModel(scenes: moviesModelController.allScenes)
        self.movieModelController = moviesModelController
        mapView = MapAndScenesCarouselView(scenes: moviesModelController.allScenes, title: "All")
        super.init(nibName: nil, bundle: nil)
        
        moviesModelController.moviesUpdated$
            .subscribe(onNext: { [weak self] movies in
                let scenes = movies.flatMap { $0.scenes }
                self?.mapView.update(scenes: scenes)
                print("Scenes in MapView have been updated")
            })
        .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupObservables()
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if mapView.scenesHidden {
            mapView.scenesHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}

private extension LocalizationViewController {
    
    private func setupViews() {
        view.addSubview(mapView)
        
        searchBar.barStyle = .default
//        view.addSubview(searchBar)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
//        
//        searchBar.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(10)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
//        }
    }
    
    private func setupObservables() {
        mapView.openSceneDetail$
            .subscribe(onNext: { scenes, index in
                self.openSceneDetail(scenes: scenes, index: index)
            }).disposed(by: disposeBag) // TODO: reload dispose bag when viewController dissaper???
    }
    
    private func openSceneDetail(scenes: [Scene], index: Int) {
        let sceneDetailViewController = SceneDetailViewController(scenes: scenes, currentIndex: index, title: "All")
        sceneDetailViewController.modalPresentationStyle = .overFullScreen
        self.present(sceneDetailViewController, animated: true, completion: nil)
    }
}

extension LocalizationViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        //todo: show potential results
        if searchText.isEmpty {
            mapView.update(scenes: viewModel.scenes)
        }
       
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if let movies = viewModel.getMovie(for: searchText) {
                print(movies)
                mapView.update(movie: movies.first!)
            }
        }
        searchBar.resignFirstResponder()
    }
}
