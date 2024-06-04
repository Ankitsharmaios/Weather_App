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

enum Helvetica: String {
  
    case helvetica_bold = "Helvetica-Bold"
    case helvetica_medium = "Helvetica-Medium"
    case helvetica_regular = "Helvetica"
    case helvetica_semibold = "Helvetica-SemiBold"
  
    func font(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
}
enum FontStyle: String {
    case font1 = "font1"
    case font2 = "font2"
    case font3 = "font3"
    case font4 = "font4"
    case font5 = "font5"
    case font6 = "font6"
    case font7 = "font7"
    
    func font(size: CGFloat) -> UIFont {
        return UIFont(name: "FontStyle-\(rawValue)", size: size)!
    }
}
