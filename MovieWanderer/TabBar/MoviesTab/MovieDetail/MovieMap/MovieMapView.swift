//
//  MovieMapView.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 17.03.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import GoogleMaps

class MovieMapView: UIView {
    
    let mapView: MapView = {
        let view = MapView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(mapView)
        

        
        let width = UIScreen.main.bounds.width
        autoSetDimensions(to: CGSize(width: width, height: 400))
        
        mapView.autoSetDimensions(to: CGSize(width: 300, height: 300))
        
//        mapView.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
//        mapView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 30)
//        mapView.autoPinEdge(toSuperviewEdge: .left, withInset: 30)
//        mapView.autoPinEdge(toSuperviewEdge: .right, withInset: 30)
        mapView.autoCenterInSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
