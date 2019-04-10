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
    private let viewModel: MovieDetailViewModel
    private let scenesTitleLabel = UILabel()
    private let backButton = UIButton()
    private let numberOfPlacesLabel = UILabel()
    private let animatingBarView = AnimatingBarView()
   
    private var currentStyle = UIStatusBarStyle.lightContent {
        didSet {
            backButton.tintColor = currentStyle == .lightContent ? .white : .black
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    // MARK: Init
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        verticalScenesView = VerticalScenesView(movie: viewModel.movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        setupObservables()
        
        self.verticalScenesView.setScenes(scenes: viewModel.scenes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return currentStyle
    }
}

private extension MovieDetailViewController {
    
    private func setupViews() {
        title = viewModel.title
        view.backgroundColor = .white
        
        view.addSubview(verticalScenesView)
        view.addSubview(animatingBarView)
        
        let backButtonImage = UIImage(named: "back-icon")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .white
        let inset: CGFloat = 5
        backButton.imageEdgeInsets =  UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        view.addSubview(backButton)
    }
    
    private func setupContraints() {
        verticalScenesView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        animatingBarView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).inset(44)
        }

        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(animatingBarView).offset(10)
            make.leading.equalToSuperview().inset(15)
            make.height.width.equalTo(30)
        }
    }
    
    private func setupObservables() {
        
        verticalScenesView.showMapTapped$
            .subscribe(onNext: { [unowned self] _ in
                let modalViewController = MapViewController(scenes: self.viewModel.scenes, title: self.viewModel.movie.title)
                self.present(modalViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        //TODO: scenestableView should be private, expose only click
        verticalScenesView.scenesTableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] index in
                guard index.row > 0 else { return }
                let correctIndex = index.row - 1 // because first cell is expendable cell
                let sceneDetailViewController = SceneDetailViewController(scenes: self.viewModel.scenes,
                                                                          currentIndex: correctIndex,
                                                                          title: self.viewModel.movie.title,
                                                                          navigationModelController: MapNavigationModelController())
                sceneDetailViewController.modalPresentationStyle = .overFullScreen
                self.present(sceneDetailViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        verticalScenesView.updateStatusBarStyle$
            .subscribe(onNext: { style in
                self.currentStyle = style
            })
            .disposed(by: disposeBag)
        
        verticalScenesView.updateNavigationBarAlpha$
            .subscribe(onNext: { alpha in
                self.animatingBarView.setColorWith(alpha: alpha)
            })
            .disposed(by: disposeBag)
    }
}



