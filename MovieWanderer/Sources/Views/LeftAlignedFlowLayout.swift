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
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//
//        let spacing = self.minimumLineSpacing
//        let cellWidth : CGFloat = Constants.ScenesCollection.cellWidth // TODO: make this generic
//        let index = proposedContentOffset.x / cellWidth
//
//        let roundedIndex = abs(index.rounded())
//        print(roundedIndex)

//        let lastIndex: CGFloat = 5
//        var x = roundedIndex * (cellWidth + spacing)
//
////        if roundedIndex == lastIndex {
//////            x = ((lastIndex * cellWidth) + UIScreen.main.bounds.width * 0.25) - spacing
////            x = x + 1000
////        }
//        return CGPoint(x: x ,y: proposedContentOffset.y)
//    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        // Page width used for estimating and calculating paging.
//        let pageWidth = self.itemSize.width + self.minimumLineSpacing
        let pageWidth = Constants.ScenesCollection.cellWidth + self.minimumLineSpacing

        // Make an estimation of the current page position.
        let approximatePage = proposedContentOffset.x / pageWidth

        // Determine the current page based on velocity.
        let currentPage = (velocity.x < 0.0) ? floor(approximatePage) : ceil(approximatePage)

        // Create custom flickVelocity.
        let flickVelocity = velocity.x * 0.3

        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

        // Calculate newHorizontalOffset.
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - self.collectionView!.contentInset.left

        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }
    
    
}
