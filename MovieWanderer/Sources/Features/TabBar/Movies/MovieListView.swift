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
    
    let refreshControl = UIRefreshControl()
    
    var movies = [Movie]() {
        didSet {
            movieTableView.reloadData()
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
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = true
        tableView.bounces = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource

extension MovieListView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = movies.count
        return count == 0 ? 3 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath)
        
        if let movieCell = cell as? MovieTableViewCell {
            if movies.count != 0 {
                let viewModel = MovieCellViewModel(movie: movies[indexPath.row])
                movieCell.bindViewModel(viewModel)
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieListView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard movies.count > 0 else { return }
        let selectedMovie = movies[indexPath.row]
        _movieTapped.onNext(selectedMovie)
    }
}

private extension MovieListView {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        refreshControl.tintColor = .brightPink
        refreshControl.attributedTitle = NSAttributedString(string: "Downloading movies...")
        movieTableView.refreshControl = refreshControl

        addSubview(movieTableView)
    }
    
    private func setupConstraints() {
        movieTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

