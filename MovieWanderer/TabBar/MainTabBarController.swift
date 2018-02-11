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

        
        let exploreViewController = ExploreViewController()
        let localizationViewController = LocalizationViewController()
        let movieListViewController = MovieListViewController()
        let profileViewController = ProfileViewController()
        
        exploreViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        localizationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        movieListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        
        
        viewControllers = [exploreViewController,localizationViewController, movieListViewController, profileViewController ]
    }


}
