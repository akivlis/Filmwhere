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

        setupViews()
        loadTabs()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

private extension MainTabBarController {
    
    private func setupViews() {
        tabBar.tintColor = UIColor(named: "brightPink")
        tabBar.barTintColor = UIColor.systemBackground
        tabBar.backgroundColor = UIColor.systemBackground
    }
    
    private func loadTabs(){
        let moviesModelController = MoviesModelController(movies: [Movie]())
        moviesModelController.loadMovies()
        
        let movieListViewController = UINavigationController(rootViewController: MovieListViewController(moviesModelController: moviesModelController))
        let locationViewController = LocationViewController(viewModel: LocationViewModel())
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        
        let controllers = [movieListViewController, locationViewController, settingsViewController]
        
        controllers.enumerated().forEach {
            let tab = Tab.allCases[$0.offset]
            let tabBarItem = UITabBarItem(title: tab.title, image: UIImage(named: tab.imageName), tag: tab.rawValue)
            $0.element.tabBarItem = tabBarItem
        }
        viewControllers = controllers
        selectedViewController = viewControllers?.first
    }
}


enum Tab: Int, CaseIterable {
    case movies
    case location
    case settings
    
    var title: String {
        switch self {
        case .movies:
            return "Movies".localized
        case .location:
            return "Map".localized
        case .settings:
            return "Settings".localized
        }
    }
    
    var imageName: String {
        switch self {
        case .movies:
            return "movies-icon"
        case .location:
            return "map-icon"
        case .settings:
            return "settings-icon"
        }
    }
}
