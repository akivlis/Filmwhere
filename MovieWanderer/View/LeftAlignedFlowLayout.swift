//
//  LeftAlignedFlowLayout.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 25.07.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit

class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let spacing = self.minimumLineSpacing
//        print("item size width: \(self.itemSize.width)")
        let cellWidth : CGFloat = 320 // TODO: make this generic
        let index = proposedContentOffset.x / cellWidth
        
        let roundedIndex = abs(index.rounded())
        let x = roundedIndex * (cellWidth + spacing)
        print(x)
        return CGPoint(x: x ,y: proposedContentOffset.y)
    }
    
}
