//
//  MovieDetailViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class MovieDetailViewController: UIViewController {

    private let verticalScenesView : VerticalScenesView
    private let disposeBag = DisposeBag()
    private let movie: Movie
    private let scenesTitleLabel = UILabel()
    private let backButton = UIButton()
    private let numberOfPlacesLabel = UILabel()

    // MARK: Init
    
    init(movie: Movie) {
        self.movie = movie
        verticalScenesView = VerticalScenesView(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupViews()
        setupContraints()
        setupObservables()
    }
}

private extension MovieDetailViewController {
    
    private func setupViews() {
        title = self.movie.title
        view.backgroundColor = .white
        view.addSubview(verticalScenesView)
        
        backButton.setImage(UIImage(named: "back-icon"), for: .normal)
//        view.addSubview(backButton)
    }
    
    private func setupContraints() {
        verticalScenesView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupObservables() {
        
//        movieHeaderView.goToMap$
//            .subscribe(onNext: { [unowned self] _ in
//                let modalViewController = MapViewController(places: self.movie.scenes)
//                self.present(modalViewController, animated: true, completion: nil)
//            }).disposed(by: disposeBag)
        
        //TODO: scenestableView should be private, expose only click
        verticalScenesView.scenesCollectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self]_ in
                let sceneDetailViewController = SceneDetailViewController()
                self.present(sceneDetailViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        verticalScenesView.scenesCollectionView.rx.didScroll
            .subscribe(onNext: { _ in
//                print(self.verticalScenesView.scenesCollectionView.contentOffset.y)
                
                var offset = self.verticalScenesView.scenesCollectionView.contentOffset.y / 150 //check this number
                if offset > 1 {
                    offset = 1
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        self.navigationController?.navigationBar.shadowImage = nil
                        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.black]
                        self.navigationController?.navigationBar.layoutIfNeeded()
                        print("show")
                    })

                } else {
                    UIView.animate(withDuration: 0.25, animations: {
                        self.navigationController?.navigationBar.shadowImage = UIImage()
                        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.clear]
                        self.navigationController?.navigationBar.layoutIfNeeded()
                        print("hide")
                    })
                }
                
                
                
//                let color = UIColor.black.withAlphaComponent(offset)
//                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): color]

//                self.navigationController?.navigationBar.backgroundColor =  color
                //        self.navigationController?.navigationBar.tintColor = color
                //        UIApplication.shared.statusBarView?.backgroundColor = color
                
                print(offset)
                
            })
    }
}




