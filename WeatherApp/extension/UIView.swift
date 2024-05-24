//
//  UIView.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 24/05/24.
//

import Foundation
import UIKit
extension UIView{
    func addShadowToView(view: UIView, value: CGFloat) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: value, height: value)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
    }
    func addShadowToTableView(view: UITableView, value: CGFloat) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: value, height: value)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
    }
    func addShadowToCollectionView(view: UICollectionView, value: CGFloat) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: value, height: value)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
    }
}
