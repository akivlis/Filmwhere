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
        static let cellWidth: CGFloat = CGFloat(Int((UIScreen.main.bounds.width / 4) * 3))
        static let lineSpacing: CGFloat = 10
    }
    
    static let movieDetailViewControllerPadding: CGFloat = 20
}

class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        // TODO: this should use itemSize.width
        let pageWidth = Constants.ScenesCollection.cellWidth + self.minimumLineSpacing
        let approximatePage = proposedContentOffset.x / pageWidth

        // Determine the current page based on velocity.
        let currentPage = (velocity.x < 0.0) ? floor(approximatePage) : ceil(approximatePage)

        // Create custom flickVelocity.
        let flickVelocity = velocity.x * 0.3
        
        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

        // Calculate newHorizontalOffset.
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) //- self.collectionView!.contentInset.left
//
//        let lastIndex: CGFloat = 5
//        if lastIndex == 5 {
//            return proposedContentOffset
//        }

        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }
}
