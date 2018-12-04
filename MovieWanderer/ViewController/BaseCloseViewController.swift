//
//  BaseCloseViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 03.12.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import RxSwift

// ViewController with close button on the right side

class BaseCloseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private let  dismissOnPullDown: Bool
    private let closeButton = UIButton(type: UIButton.ButtonType.system)
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var originalPosition: CGPoint?
    private var currentPositionTouched: CGPoint?
    
    init(dismissOnPullDown: Bool = false) {
        self.dismissOnPullDown = dismissOnPullDown
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dismissOnPullDown = false
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        dismissOnPullDown = false
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dismissOnPullDown {
            addPanGestureRecognizer()
        }
    }
}

private extension BaseCloseViewController {
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    private func setupViews() {
        if let image = UIImage(named: "close-icon")?.withRenderingMode(.alwaysTemplate) {
            closeButton.setImage(image, for: .normal)
        }
        closeButton.tintColor = .white
        closeButton.imageEdgeInsets =  UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.leading.equalToSuperview().inset(15)
            make.height.width.equalTo(25)
        }
    }
    
    private func setupObservables() {
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
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
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(
                x: view.frame.origin.x,
                y: translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height
                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        }
    }
}

