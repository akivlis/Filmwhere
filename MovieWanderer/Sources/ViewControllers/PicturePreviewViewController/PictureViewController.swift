//
//  PictureViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 02.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

class PictureViewController: BaseCloseViewController {
    
    @IBOutlet weak var currentImageView: UIImageView!
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var originalPosition: CGPoint?
    private var currentPositionTouched: CGPoint?
    
    let pictures: [UIImage]
    
    init(pictures: [UIImage]) {
        self.pictures = pictures
        super.init(dismissOnPullDown: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.pictures = [UIImage]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        
        canRotate()
        
        //TODO: implement for multiple pictures
        if let picture = pictures.first {
            currentImageView.image = picture
        } else {
            currentImageView.image = nil
        }
        
        view.addTopGradient()
        addPanGestureRecognizer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isBeingDismissed) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func canRotate() -> Void {}
}

private extension PictureViewController {
    private func addPanGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer()
        view.addGestureRecognizer(panGestureRecognizer!)
        
        panGestureRecognizer!.rx.event
            .subscribe(onNext: { [weak self] panGesture in
                self?.panGestureAction(panGesture)
            })
            .disposed(by: disposeBag)
    }
    
    private func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = currentImageView.center
            currentPositionTouched = panGesture.location(in: view)
            closeButton.isHidden = true
            self.view.hideTopGradient()
        } else if panGesture.state == .changed {
            currentImageView.frame.origin = CGPoint(x: translation.x,
                                                    y: translation.y)
            let positive = abs(translation.y)
            let alpha = 1 - (positive / self.view.frame.size.height)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(alpha)
            
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        // move the whole view down
                        self.currentImageView.frame.origin = CGPoint(x: self.currentImageView.frame.origin.x,
                                                                     y: self.currentImageView.frame.size.height)
                        self.view.backgroundColor = UIColor.clear
                        self.view.hideTopGradient()
                }, completion: { isCompleted in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.currentImageView.center = self.originalPosition!
                    self.view.backgroundColor = UIColor.black
                    self.closeButton.isHidden = false
                    self.view.showTopGradient()
                })
            }
        }
    }
}
