//
//  AppResources.swift
//  UniviaFarmer
//
//  Created by Nik on 17/01/23.
//

import Foundation
import UIKit

enum Nunitonsans: String {
    case nuniton_black = "Black"
    case nuniton_bold = "Bold"
    case nuniton_extraBold = "ExtraBold"
    case nuniton_regular = "Regular"
    case nuniton_semiBold = "SemiBold"
    case balackItalic = "BlackItalic"
    case boldItalic = "BoldItalic"
    case extraBoldItalic = "ExtraBoldItalic"
    case etraLight = "ExtraLight"
    case etraLightItalic = "ExtraLightItalic"
    case italic = "Italic"
    case light = "Light"
    case lightItalic = "LightItalic"
    case semiBoldItalic = "SemiBoldItalic"
    
    func font(size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-\(rawValue)", size: size)!
    }
}
//enum Helvetica: String {
//  
//    case helvetica_bold = "Bold"
//    case helvetica_medium = "medium"
//    case helvetica_regular = "Regular"
//    case helvetica_semibold = "SemiBold"
//  
//    
//    func font(size: CGFloat) -> UIFont {
//        return UIFont(name: "Helvetica-\(rawValue)", size: size)!
//    }
//}
enum Helvetica: String {
  
    case helvetica_bold = "Helvetica-Bold"
    case helvetica_medium = "Helvetica-Medium"
    case helvetica_regular = "Helvetica"
    case helvetica_semibold = "Helvetica-SemiBold"
  
    func font(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
}

