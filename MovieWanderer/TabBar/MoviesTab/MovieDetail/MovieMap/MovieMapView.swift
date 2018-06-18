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
       
        //todo remove
        self.snp.makeConstraints { make in
            make.width.height.equalTo(400)
        }
        
        mapView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
