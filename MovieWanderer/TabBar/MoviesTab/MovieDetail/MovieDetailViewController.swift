//
//  MovieDetailViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailViewController: UIViewController {

    fileprivate let scrollView = UIScrollView()
//    fileprivate let movieDetailView = UserProfileStackView(viewModel: UserProfileStackViewViewModel())
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red

    }
    


}

fileprivate extension MovieDetailViewController {
    
    func loadSubviews() {
        view.addSubview(scrollView)
//        scrollView.addSubview(userProfileView)
    }
    
    func setContraints() {
        
        let padding: CGFloat = 12

        scrollView.autoPinEdge(toSuperviewEdge: .left, withInset: padding)
        scrollView.autoPinEdge(toSuperviewEdge: .right, withInset: padding)
        scrollView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        scrollView.autoPinToSafeArea(.bottom, of: self, withInset: 0, insetForDeviceWithNotch: 0)
        
//        userProfileView.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
//        userProfileView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
//        userProfileView.autoPinEdge(toSuperviewEdge: .left)
//        userProfileView.autoPinEdge(toSuperviewEdge: .right)
//
//        userProfileView.autoMatch(.width, to: .width, of: scrollView)
    }

}
