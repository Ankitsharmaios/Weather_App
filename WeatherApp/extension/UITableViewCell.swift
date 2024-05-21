//
//  UITableViewCell.swift
//  UniviaFarmer
//
//  Created by Nik on 17/01/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var indexPath: IndexPath? {
        var tableView = superview
        while let view = tableView, !view.isKind(of: UITableView.self) {
            tableView = view.superview
        }
        if let tableView = tableView as? UITableView {
            return tableView.indexPath(for: self)
        }
        return nil
    }
}

