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
        tabBar.tintColor = UIColor.darkGreen
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundColor = UIColor.white
    }
    
    private func loadTabs(){
        let movieListViewController = MovieListViewController()
        movieListViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movies-icon"), tag: 0)
        
        
       let localizationViewController = loadLocalizationViewController()
        localizationViewController.tabBarItem = UITabBarItem(title: "Maps", image: UIImage(named: "map-icon"), tag: 1)

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-icon"), tag: 2)
        
        let movieNavigationViewController = UINavigationController(rootViewController: movieListViewController)
        let profileNavigationViewController = UINavigationController(rootViewController: profileViewController)

        
        viewControllers = [movieNavigationViewController, localizationViewController, profileNavigationViewController ]
        selectedViewController = movieNavigationViewController
    }
    


}

private func loadLocalizationViewController() -> LocalizationViewController {

    
    let dummyScenes : [Scene] = [
        Scene(title: "Rocky", description: "Hahaha", latitude:39.962920, longitude: -75.157235, imageURL: "Rocky_running"),
        Scene(title: "Rocky running", description: "Dubrovnik", latitude: 42.645942, longitude: 18.090084),
        Scene(title: "Rocky boxing", description: "Vienn Opera", latitude:  48.202840, longitude: 16.368916),
        Scene(title: "Rocky something", description: "Hofburg", latitude:  48.208347, longitude: 16.366143),
        Scene(title: "Rocky something else", description: "Spanish stairs", latitude:  41.899355, longitude: 12.484746)
    ]
    
    let missionImpossibleScenes = [
        Scene(title: "Ethan hunt in the opera", description: "Vienn Opera", latitude:  48.202840, longitude: 16.368916),
        Scene(title: "Ethan hunt in Hofburg", description: "Hofburg", latitude:  48.208347, longitude: 16.366143)
    ]
    
    let gameOfThronesScenes = [Scene(title: "Jamie", description: "Hahaha", latitude: 48.225660, longitude: 16.399509),
                               Scene(title: "Lokrum", description: "Hihihhi", latitude: 48.228176, longitude: 16.395046),
                               Scene(title: "Stairs", description: "Bla bla bla", latitude: 48.206959, longitude: 16.390454),
                               Scene(title: "Dany", description: "Bla bla bla", latitude:  48.157614, longitude: 17.075666)
    ]
    
    let dummyMovies =  [
        Movie(title: "Mission Imposible", description: "Liz Gilbert (Julia Roberts) thought she had everything she wanted in life: a home, a husband and a successful career. Now newly divorced and facing a turning point, she finds that she is confused about what is important to her. Daring to step out of her comfort zone, Liz embarks on a quest of self-discovery that takes her to Italy, India and Bali.", scenes: missionImpossibleScenes, imageUrl: "eat_pray"),
        Movie(title: "Game Of Thrones", description: "Game of thrones is an american", scenes: gameOfThronesScenes, imageUrl: "Rocky"),
        Movie(title: "Rocky", description: "A boxer decides to change his life, so he starts training for the worlds biggest competition in Philadephia. He needs to put all his forces into this fight and so on and on ", scenes: dummyScenes, imageUrl: "Rocky_running"),
        ]
    
    
    let viewModel = LocalizationViewModel(movies: dummyMovies)
    return LocalizationViewController(viewModel: viewModel)
    
    
}
