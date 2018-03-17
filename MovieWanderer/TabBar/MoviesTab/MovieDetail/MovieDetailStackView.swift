//
//  File.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class MovieDetailStackView: UIStackView {
    
    let movieDetailHeaderView: ProfileHeaderView
    let movieScenesView: TrackProgressView
    var movieMapView: ProfileBadgeView
    
    fileprivate let viewModel: UserProfileStackViewViewModel
    fileprivate let disposeBag = DisposeBag()
    
    init(viewModel: UserProfileStackViewViewModel) {
        self.viewModel = viewModel
        
        profileHeaderView = ProfileHeaderView(name: viewModel.username, pictureUrl: viewModel.userPicture, premium: viewModel.hasPremium)
        trackProgressView = TrackProgressView(favoriteTracks: viewModel.getFavoriteTracks())
        profileBadgeView = ProfileBadgeView(badges: [Badge]())
        
        super.init(frame: .zero)
        loadSubviews()
        
        profileBadgeView.isHidden = true
        
        distribution = .fill
        spacing = 0
        alignment = .fill
        axis = .vertical
    }
    
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        
        viewModel.getBadges()
            .subscribe(onNext: { [unowned self] result in
                
                switch result {
                    
                case let .success(badges):
                    if badges.count > 0 {
                        // sort badges according to completed
                        let sortedBadges = badges.sorted { $0.isCompleted && !$1.isCompleted }
                        
                        self.profileBadgeView.setBadges(badges: sortedBadges, showOnlyCompleted: false)
                        self.profileBadgeView.isHidden = false
                    } else {
                        self.profileBadgeView.isHidden = true
                    }
                case .failure:
                    self.profileBadgeView.isHidden = true
                }
                
            }).disposed(by: disposeBag)
        
        trackProgressView.setFavoriteTracks(favoriteTracks: viewModel.getFavoriteTracks())
        
        viewModel.getUserInfo()
            .subscribe(onNext: { userInfo in
                self.profileHeaderView.updateWith(name: userInfo.username, pictureUrl: userInfo.pictureURL, hasPremium: self.viewModel.hasPremium)
            }).disposed(by: disposeBag)
    }
    
    func stopObservingForLessonProgressInDb() {
        trackProgressView.stopNotificationToken()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileBadgeView.roundCorners([.allCorners], radius: 8) // pass all corners to not use the layer.mask which breaks the animation
        profileHeaderView.roundCorners([.topLeft, .topRight], radius: 8)
        
        if profileBadgeView.isHidden {
            trackProgressView.roundCorners([.allCorners], radius: 8)
        } else {
            trackProgressView.roundCorners([.allCorners], radius: 0)
        }
    }
    
    fileprivate func loadSubviews() {
        
        addArrangedSubview(profileHeaderView)
        addArrangedSubview(trackProgressView)
        addArrangedSubview(profileBadgeView)
    }
}
