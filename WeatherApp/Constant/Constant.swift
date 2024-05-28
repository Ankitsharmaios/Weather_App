//
//  Constant.swift
//  UniviaFarmer
//
//  Created by Nik on 16/01/23.
//

import Foundation
import UIKit


//User token
enum UserToken {
    static var userToken = ""
}

enum UserLoginData {
 //   static var userData: VerifyOTPModel?
    static var languageID = ""
    static var Longitude = 0.0
    static var Latitude = 0.0
    static var StateName = "Gujarat"
    static var CityName = "New Delhi"
}

//enum CompanyDetailsData {
//    static var companyDetailsModel: CompanyDetailsModel?
//}

enum userDefaultsKeys: String {
    case token = "UserToken"
    case userdata = "UserData"
    case languageID = "languageID"
    case languageData = "LanguageData"
    case NotificationCount = "NotificationCount"
    case CartCount = "CartCount"
    case RegisterId = "RegisterId"
}
//
//App setting
enum AppSetting {
//    "UGA" // Univia galaxy partner
//    "UFA" // Univia farmer app
    
//    static let AppCode = "Univia.UFA.06bdc8fb52386e69a9258574e7f325c0"
//    static let AppId = "Univia.UFA.194e1181a179dc386bfdd1f0e5cdf287"
    static let AppName = "WeatherApp"
    static let DeviceId = UIDevice.current.identifierForVendor!.uuidString
    static let DeviceType = "iOS"
//    static let CurrencySybols = "₹ "
//    static let NumberOfDigit = 2
//    static let KMDigit = 1
//    static let FeetDigit = 2
//    static let SetMarqueeLabelTime = 7.0
    static var DeviceVersion = UIDevice.current.systemVersion
    static var FCMTokenString = "Device Token simulator"
}

enum AppKeys: String {
//    case GoogleMapKey = "AIzaSyD7oq-sqNcyM1TrJHjkEcw2mqaUhrLlnhM"
//    case RazorpayKey = "rzp_test_4vUFu4whz3SExf"
//    case RazorpayKey = "rzp_live_i5N7F5A9aWt0pY"
    
    case WeatherKey = "4cb131e12591438f9fe43510241705"
}

struct Constants
{
    struct Storyboard {
        static let Main = "Main"
        static let PopUp = "PopUp"
        static let DashBoard = "DashBoard"
    }
}
enum APILogMessage {
//    static var userData = "LoginModel"
    static var UnAuthorize = "User unauthorised access.".lowercased()
    static var UnAuthorizeStatus = false
    static var PassVC = "UnAuthorise"
}
enum firebaseTableName: String{
    case Chat = "Chat"
    case LastChat = "LastChat"
    case User = "User"
}
