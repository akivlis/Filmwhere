//
//  LeftAlignedFlowLayout.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 25.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

struct Constants {
    struct ScenesCollection {
        static let cellWidth: CGFloat = UIScreen.main.bounds.width - 60 // TODO: calculate correct width
        static let lineSpacing: CGFloat = 10
    }
    
    static let movieDetailViewControllerPadding: CGFloat = 10
}

class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let spacing = self.minimumLineSpacing
        let cellWidth : CGFloat = Constants.ScenesCollection.cellWidth // TODO: make this generic
        let index = proposedContentOffset.x / cellWidth
        
        let roundedIndex = abs(index.rounded())
        let x = roundedIndex * (cellWidth + spacing)
        return CGPoint(x: x ,y: proposedContentOffset.y)
    }
    
}
