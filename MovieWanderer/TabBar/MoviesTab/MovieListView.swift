//
//  MovieListView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift


final class MovieListView : UIView  {
    
    var movies = [Movie]() {
        didSet {
            layoutSubviews()
        }
    }
    
    private var _movieTapped = PublishSubject<Movie>()
    var movieTapped$: Observable<Movie> {
        return _movieTapped
    }
    
    let movieTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsHorizontalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = true
        tableView.bounces = true
        tableView.register(MovieTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        addSubview(movieTableView)
        
        movieTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

// MARK: - UITableViewDataSource

extension MovieListView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath)
        
        if let movieCell = cell as? MovieTableViewCell {
            let viewModel = MovieCellViewModel(movie: movies[indexPath.row])
            movieCell.bindViewModel(viewModel)
        }
        return cell
    }

}

// MARK: - UITableViewDelegate

extension MovieListView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let selectedMovie = movies[indexPath.row]
        _movieTapped.onNext(selectedMovie)
    }
    
}

