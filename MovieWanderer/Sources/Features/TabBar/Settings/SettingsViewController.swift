//
//  SettingsViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupObservables()
    }
}

private extension SettingsViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    private func setupViews(){
        title = "Settings"
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupObservables() {
        
    }
}
