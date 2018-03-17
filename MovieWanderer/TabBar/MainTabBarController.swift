//
//  MainTabBarController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
//    fileprivate let viewControllers: [UIViewController]

    override func viewDidLoad() {
        super.viewDidLoad()

        loadTabs()
        
        tabBar.backgroundColor = .white
        
       
    }
    
    fileprivate func loadTabs(){
        
        let exploreViewController = ExploreViewController()
        exploreViewController.tabBarItem = UITabBarItem(title: "Highlights", image: UIImage(named: "favorite"), tag: 0)
        
        let localizationViewController = LocalizationViewController()
        localizationViewController.tabBarItem = UITabBarItem(title: "Maps", image: UIImage(named: "map"), tag: 1)

        let movieListViewController = MovieListViewController()
        movieListViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie"), tag: 2)

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 3)
        
        
        let movieNavigationViewController = UINavigationController(rootViewController: movieListViewController)
        
        
        viewControllers = [exploreViewController,localizationViewController, movieNavigationViewController, profileViewController ]
        
        selectedViewController = exploreViewController
    }
    


}
