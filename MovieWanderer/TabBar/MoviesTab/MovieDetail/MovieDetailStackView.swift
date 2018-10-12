//
//  File.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MovieDetailStackView: UIStackView {
    //remove this class
    
//    let movieDetailHeaderView: MovieHeaderView
    let movieScenesView: MovieScenesView
    
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
//        movieDetailHeaderView = MovieHeaderView(viewModel: viewModel.movieHeaderViewModel)
        movieScenesView = MovieScenesView()
        
        super.init(frame: .zero)
        
        loadSubviews()
        
        distribution = .fill
        spacing = 0
        alignment = .fill
        axis = .vertical
    }
    
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        
       
    }
}

private extension MovieDetailStackView {

    private func loadSubviews() {
//        addArrangedSubview(movieDetailHeaderView)
        addArrangedSubview(movieScenesView)
    }
}
