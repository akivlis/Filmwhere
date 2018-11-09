//
//  MovieWanderer+Reusable.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05.06.18.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import MapKit

public protocol Reuseable: class {
    static var reuseIdentifier: String { get }
}

extension Reuseable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reuseable {}
extension UITableViewHeaderFooterView: Reuseable {}
extension UICollectionReusableView: Reuseable {}
extension MKAnnotationView: Reuseable {}

extension UITableView {
    public func register<T: Reuseable>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    public func register<T: Reuseable>(headerFooter view: T.Type) {
        register(view, forHeaderFooterViewReuseIdentifier: view.reuseIdentifier)
    }
    
    public func register<T: Reuseable>(nibName: String, cell: T.Type) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
    }
}

extension UICollectionView {
    public func register<T: Reuseable>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    public func register<T: Reuseable>(header view: T.Type) {
        register(view, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: view.reuseIdentifier)
    }
    
    public func register<T: Reuseable>(footer view: T.Type) {
        register(view, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: view.reuseIdentifier)
    }
    
    public func register<T: Reuseable>(nibName: String, cell: T.Type) {
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: cell.reuseIdentifier)
    }}

//extension MKAnnotationView {
//    public func register<T: Reuseable>(_ annotationView: T.Type) {
//        register(annotationView, forAnnotationViewWithReuseIdentifier: annotationView.reuseIdentifier)
//    }
//
//}
