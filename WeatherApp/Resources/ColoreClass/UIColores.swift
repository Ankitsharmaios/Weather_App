//
//  UIColores.swift
//  Good Practice
//
//  Created by Excelsior Technologies - Komal on 06/11/23.
//

import Foundation
//
//  AppColor.swift
//  UD Instructor
//
//  Created by Kushal Patel on 03/01/22.
//


import UIKit

fileprivate var style : Bool = false

var isDark : Bool {
    set {
        if newValue != style {
            //            style = newValue
            //            AppUserDefaults.isDarkMode = newValue
            //            NotificationCenter.default.post(name: .changeTheme , object: nil)
            //            appTheamColor = AppColor()
        }
    }
    get {
        return style
    }
}

var appThemeColor = AppColor()

class AppColor {
  
    //Ankit Weather Colures
    var citynameColure : UIColor = { // #242d33
        return  #colorLiteral(red: 0.1411764706, green: 0.1764705882, blue: 0.2, alpha: 1)
    }()
    var  white : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }()
    var CommonBlack : UIColor = {
        return  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)  //F7F7F7
    }()
    var selectedCityColure : UIColor = {
        return  #colorLiteral(red: 0, green: 0.5019607843, blue: 0.4117647059, alpha: 1)  //  #008069
    }()
    
    //================================ ==========================================
 /*
    var greyEdit : UIColor = { // CCCCCC
        return  #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }()
    var EditBox : UIColor = { // F5F5F5
        return  #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    }()
    var Textblack100 : UIColor = {
        return  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }()
    var TextDategrey100 : UIColor = {
        return  #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    }()
   
    //#228117
    var  Green : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.1333333333, green: 0.5058823529, blue: 0.09019607843, alpha: 1)
        
    }()
    var  Yellow : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        
    }()
    
    var  Dark_Grey : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
    }()
    var  blue : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.1411764706, green: 0.4666666667, blue: 0.8862745098, alpha: 1)
        
    }()
    var  light_Grey : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        
    }()
    var  reflactioncolore : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.4784313725, green: 0.4823529412, blue: 0.4666666667, alpha: 1)
        
    }()
    var  red : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.8, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
        
    }()
    var  bordercolor : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6352941176, alpha: 1)
        
    }()
    var  dark_Green : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0, green: 0.4941176471, blue: 0.3411764706, alpha: 1)
        
    }()
    var  dark_Red : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.7176470588, green: 0.03921568627, blue: 0.02352941176, alpha: 1)
        
    }()
    var  Grey_line : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
    }()
    var  Light_green : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.9137254902, green: 0.9529411765, blue: 0.937254902, alpha: 1) //E9F3EF
       
    }()
    
    var  Light_blue : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.8196078431, green: 0.8745098039, blue: 0.9843137255, alpha: 1)
        
    }()
    var  Light_Green : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.2039215686, green: 0.6745098039, blue: 0.3098039216, alpha: 1)
        
    }()
    var  Dark_blue : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.2862745098, green: 0.5019607843, blue: 0.937254902, alpha: 1)
        
    }()
    var  Dark_greyLbl : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1)
        
    }()
    var  greyLine : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        
    }()
    var  redLine : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.9803921569, green: 0.06274509804, blue: 0.07843137255, alpha: 1)
        
    }()
    var  purpleLinecolore : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.7294117647, green: 0.4392156863, blue: 0.7137254902, alpha: 1)
        
    }()
    var  redLineColore : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.7921568627, green: 0.06274509804, blue: 0.2745098039, alpha: 1)
        
    }()
    var  grey_background : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        
    }()
    var  orange_Colore : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.9843137255, green: 0.4666666667, blue: 0, alpha: 1)
        
    }()
    var  green_Colore : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.03529411765, alpha: 1)
        
    }()
    //#F8F8F8
    var  extraLightGray_Color : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        
    }()
    
    //#4980EF
    var  extraBlue_Color : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.2862745098, green: 0.5019607843, blue: 0.937254902, alpha: 1)
        
    }()
   //NewFirst Colores
    var AppNavigation : UIColor = {  // Use Navigationbar Submmit Button Utility Button
        return  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
    }()
    
    var appColorPrimary : UIColor = {
        return  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }()
    var Commonwhite : UIColor = {
        return  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }()
    
    var grey : UIColor = {
        return  #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)  //7E7E7E
    }()
    var lightGreyAlpha : UIColor = {
        return  #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 0.7)  //7E7E7E
    }()

    var sepGray1 : UIColor = {
        return  #colorLiteral(red: 0.6705882353, green: 0.7019607843, blue: 0.7019607843, alpha: 0.7)  //ABB3B3
    }()
    
    var sepGray2 : UIColor = {
        return  #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)  //B3B3B3
    }()
    
    var greyLight : UIColor = {
        return  #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1) //F1F1F1
    }()
    var view : UIColor = {
        return  #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9372549057, alpha: 1)  //EFEFEF
    }()
    var view1 : UIColor = {
        return  #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)  //FEFEFE
    }()
    
    var viewLight : UIColor = {
        return  #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)  //F7F7F7
    }()
    /// Change Theme Light To Dark
    var black : UIColor = {
        if isDark {
            return  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            return  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }()
    var Red : UIColor = {
        return  #colorLiteral(red: 0.6666666667, green: 0.08235294118, blue: 0.07058823529, alpha: 1) //aa1512
    }()
    
    var redAppColor : UIColor = {
        return  #colorLiteral(red: 0.6666666667, green: 0.08235294118, blue: 0.07058823529, alpha: 1) //aa1512
    }()
    var searchBackGroundColor : UIColor = {
        return  #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1) //#f1f1f1
    }()
    var YelloW:UIColor = {
        return  #colorLiteral(red: 0.9764705882, green: 0.6352941176, blue: 0.01568627451, alpha: 1) //#F9A204
    }()
    var red_light : UIColor = {
        return  #colorLiteral(red: 0.8901960784, green: 0.7098039216, blue: 0.7058823529, alpha: 1)  //E3B5B4
    }()
    var facebook : UIColor = {
        return  #colorLiteral(red: 0.1450980392, green: 0.3215686275, blue: 0.5568627451, alpha: 1)  // 25528E
    }()
    
    var green : UIColor = {
        return  #colorLiteral(red: 0.2196078431, green: 0.5568627451, blue: 0.2352941176, alpha: 1)  //388E3C
    }()
    
    var lightGreen : UIColor = {
        return  #colorLiteral(red: 0.9058823529, green: 0.9725490196, blue: 0.9098039216, alpha: 1)  //E7F8E8
    }()
    
    var lightRed : UIColor = {
        return  #colorLiteral(red: 0.9803921569, green: 0.862745098, blue: 0.862745098, alpha: 1)  //FADCDC
    }()

    var peachRed : UIColor = {
        return  #colorLiteral(red: 1, green: 0.9137254902, blue: 0.8862745098, alpha: 1)  //ffe9e2
    }()
    var dateTimegrey : UIColor = {
        return  #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)  //414141
    }()
    var tabBartint:UIColor{
        return  #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1)// d6d6d6
    }
    var reporterName : UIColor = {
        return  #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 0.7)  //414141
    }()
    var redSwitch : UIColor = {
        return  #colorLiteral(red: 0.8274509804, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
    }()
    var shimmerBackground : UIColor = {
        return  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1) //DDDDDD
    }()
    
    var redGrd : UIColor = {
        return  #colorLiteral(red: 0.8274509804, green: 0.1843137255, blue: 0.1843137255, alpha: 1) //DDDDDD
    }()
    
    var dotted_LineColor : UIColor = {
        return  #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1) //#7E7E7E
    }()
    var seprator_LineColor : UIColor = {
        return  #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1) //#7E7E7E
    }()
    
    //MARK: Survey vc
    var selected_Button_Yes : UIColor = {
        return  #colorLiteral(red: 0.1058823529, green: 0.5098039216, blue: 0.2431372549, alpha: 1) //#1B823E
    }()
    var selected_Button_No : UIColor = {
        return  #colorLiteral(red: 0.6666666667, green: 0.01568627451, blue: 0.0862745098, alpha: 1) //#AA0416
    }()
    //F03A31
    var clear_Button_yes : UIColor = {
        return  #colorLiteral(red: 1, green: 0.3725490196, blue: 0.1215686275, alpha: 1) //#7E7E7E
    }()
    var clear_Button_No : UIColor = {
        return  #colorLiteral(red: 0.2666666667, green: 0.7803921569, blue: 0.3529411765, alpha: 1) //#7E7E7E
    }()
    
    var audio_Background : UIColor = {
        return  #colorLiteral(red: 0.9529411765, green: 0.8588235294, blue: 0.7019607843, alpha: 1) //#F3DBB3
    }()
    var searchBar_background : UIColor = {
        return  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1) //#F2F2F7
    }()
    var label_color : UIColor = {
        return  #colorLiteral(red: 0.662745098, green: 0, blue: 0, alpha: 1) //#A90000
    }()
    var opinionPoll : UIColor = {
        return  #colorLiteral(red: 0.5450980392, green: 0.7411764706, blue: 1, alpha: 1) //#8BBDFF
    }()
    var opinionPoll_Back : UIColor = {
        return  #colorLiteral(red: 0.9247134328, green: 0.9565401673, blue: 1, alpha: 1) //#ECF4FF
    }()
    var opinionPoll_Progress : UIColor = {
        return  #colorLiteral(red: 0.7725490196, green: 0.8745098039, blue: 1, alpha: 1) //#C5DFFF
    }()
    var border : UIColor = {
        return  #colorLiteral(red: 0.6470588235, green: 0.8705882353, blue: 0.968627451, alpha: 1) //#E6F4FE
    }()
    var background:UIColor = {
        return #colorLiteral(red: 0.9294117647, green: 0.937254902, blue: 0.9411764706, alpha: 1) //#EDEFF0
    }()
    var liveBroadcast:UIColor = {
        return #colorLiteral(red: 0.8274509804, green: 0.1843137255, blue: 0.1843137255, alpha: 1) //#EDEFF0
    }()
    var liveButton:UIColor = {
        return #colorLiteral(red: 0.9294117647, green: 0.2588235294, blue: 0.262745098, alpha: 1) //#EDEFF0
    }()
    var darkModeSepratorColor:UIColor = {
        return #colorLiteral(red: 0.1058823529, green: 0.1411764706, blue: 0.1960784314, alpha: 1) //#EDEFF0
    }()
    
    
    var gradientTop: UIColor = {
        return .clear
        //#50aa1512
    }()
    
    var gradientBottom: UIColor = {
        return #colorLiteral(red: 0.6651116666, green: 0.08200737567, blue: 0.0721598722, alpha: 1)  //#aa1512
    }()
    
    var navyBlue: UIColor = {
        return #colorLiteral(red: 0.03137254902, green: 0.05882352941, blue: 0.1137254902, alpha: 1)  //#
    }()
    
    var Newsfirstbrk: UIColor = {
        return #colorLiteral(red: 0.6705882353, green: 0.003921568627, blue: 0.07450980392, alpha: 1)  //#AB0113
    }()
    
    var Newsyelow: UIColor = {
        return #colorLiteral(red: 1, green: 0.9333333333, blue: 0.662745098, alpha: 1)  //#FFEEA9
    }()
    var greenNews: UIColor = {
        return #colorLiteral(red: 0.2117647059, green: 0.8470588235, blue: 0.7176470588, alpha: 1)  //#36D8B7
    }()
    var greenNews2floro: UIColor = {
        return #colorLiteral(red: 0.3803921569, green: 0.9294117647, blue: 0.9176470588, alpha: 1)  //#61EDEA
    }()
    
    var fontwhite: UIColor = {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  //#61EDEA
    }()
    var fontblack: UIColor = {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)  //#61EDEA
    }()
    var Bullets: UIColor = {
        return #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)  //#414141
    }()
    var seperatorColor: UIColor = {
        return #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)  //#ECECEC
    }()
    var seperatorColor_EEEEEE: UIColor = {
        return #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)  //#EEEEEE
    }()
    var darkGreyTextColor_8C8C8C: UIColor = {
        return #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)  //#8C8C8C
    }()
    var redTabItem: UIColor = {
        return #colorLiteral(red: 0.8, green: 0.09803921569, blue: 0.09803921569, alpha: 1)  //#cc1919
    }()
    var lastDateText: UIColor = {
        return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)  //#666666
    }()
    var greyItalic: UIColor = {
        return #colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1)  //#8C8C8C
    }()

    var red_FF3A31: UIColor = {
        return #colorLiteral(red: 1, green: 0.2274509804, blue: 0.1921568627, alpha: 1)  //#FF3A31
    }()

    var BorderBlue: UIColor = {
        return #colorLiteral(red: 0.1411764706, green: 0.4666666667, blue: 0.8862745098, alpha: 1)  //#2477E2
    }()
    var tabbarIcons: UIColor = {
        return #colorLiteral(red: 0.5988945365, green: 0.5988945365, blue: 0.5988945365, alpha: 1)  //#2477E2
    }()

    var  greyBaground : UIColor = {  // Use Navigationbar Submmit Button Utility Button
           return  #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1) //F5F5F5
           
       }()
    var  SeperatorSidemenu : UIColor = {  // Use Navigationbar Submmit Button Utility Button
           return  #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1) //A0A0A0
           
       }()
    var  creamColorSidemenu : UIColor = {  // Use Navigationbar Submmit Button Utility Button
           return  #colorLiteral(red: 0.9490196078, green: 0.9294117647, blue: 0.9019607843, alpha: 1) //#f2ede6
           
       }()
    var  acentBlue : UIColor = {  // Use Navigationbar Submmit Button Utility Button
           return  #colorLiteral(red: 0, green: 0.4588235294, blue: 0.8901960784, alpha: 1) //0075E3
           
       }()
    
   */
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
extension UIColor {
    static func colorFromHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
/*
extension UIView {
    func gradientRedColor(view:UIView)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Set the colors for the gradient using your custom colors
        gradientLayer.colors = [
            appThemeColor.redLine.cgColor,
            appThemeColor.purpleLinecolore.cgColor,
            appThemeColor.redLineColore.cgColor
        ]
        
        // Optionally, set the locations for each color
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        // Optionally, set the start and end points for the gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        // Add the gradient layer to the view's layer
        view.layer.addSublayer(gradientLayer)
    }
    func addGradientBorder(colors: [UIColor], width: CGFloat) {
        // Create a gradient layer for the border
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        
        // Create a shape layer for the border path
        let borderPath = UIBezierPath(rect: bounds.insetBy(dx: width, dy: width))
        let borderLayer = CAShapeLayer()
        borderLayer.path = borderPath.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = width
        
        // Set the border layer's mask to the gradient layer
        gradientLayer.mask = borderLayer
        
        // Add the gradient layer to the view's layer
        layer.addSublayer(gradientLayer)
    }
}
*/

 
