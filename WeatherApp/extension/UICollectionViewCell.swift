//
//  UICollectionViewCell.swift
//  UniviaFarmer
//
//  Created by Nikunj on 1/20/23.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var indexPath: IndexPath? {
        var collectionView = superview
        while let view = collectionView, !view.isKind(of: UICollectionView.self) {
            collectionView = view.superview
        }
        if let collectionView = collectionView as? UICollectionView {
            return collectionView.indexPath(for: self)
        }
        return nil
    }
}
