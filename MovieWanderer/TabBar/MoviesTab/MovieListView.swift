//
//  MovieListView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 16.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

fileprivate let myCollectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 0
    return layout
}()


class MovieListView : UIView  {
    
    let cellId = "MovieCollectionCell"
    
    var movies = [Movie]() {
        didSet {
            layoutSubviews()
        }
    }
    
    fileprivate var _movieTapped = PublishSubject<Movie>()
    var movieTapped$: Observable<Movie> {
        return _movieTapped
    }
    
    let movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myCollectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.bounces = true
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        addSubview(movieCollectionView)
        
        movieCollectionView.autoPinEdgesToSuperviewEdges()
        
//        movieCollectionView.autoPinToSafeAreaOfView(.top, of: self)
//        movieCollectionView.autoPinEdge(toSuperviewEdge: .left)
//        movieCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
//        movieCollectionView.autoPinEdge(toSuperviewEdge: .right)
        
        backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension MovieListView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
        
        cell.viewModel = MovieCellViewModel(movie: movies[indexPath.row])
        
        return cell
        
    }
    
    
}

extension MovieListView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedMovie = movies[indexPath.row]
        _movieTapped.onNext(selectedMovie)
    }
    
}

extension MovieListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 20
        print(width)
        return CGSize(width: width, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
    }
    
}
