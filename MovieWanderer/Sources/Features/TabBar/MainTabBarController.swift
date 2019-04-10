//
//  MainTabBarController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTabs()
        tabBar.tintColor = UIColor.brightPink
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundColor = UIColor.white
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func loadTabs(){
        let moviesModelController = MoviesModelController(movies: [Movie]())
        moviesModelController.loadMovies()
        
        let movieListViewController = MovieListViewController(moviesModelController: moviesModelController)
        movieListViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movies-icon"), tag: 0)
        
        let locationViewController = LocationViewController(moviesModelController: moviesModelController)
        locationViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map-icon"), tag: 1)
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-icon"), tag: 2)
        
        let movieNavigationViewController = UINavigationController(rootViewController: movieListViewController)
        let profileNavigationViewController = UINavigationController(rootViewController: profileViewController)
        
        
        viewControllers = [movieNavigationViewController, locationViewController ]
        selectedViewController = movieNavigationViewController
    }

}
