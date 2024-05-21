//
//  Constant.swift
//  UniviaFarmer
//
//  Created by Nik on 16/01/23.
//

import Foundation
import UIKit

enum SetPriceSetting {
    static let numberOfDigit = 2
    static let currencySymbols = "$"
}

enum allowCharacters: String {
    case characters = "0123456789."
}

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
    static var CityName = "Ahmedabad"
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
}

//Acer Type
enum AreaTypeArray {
    static var AreaType = ["Acre", "Hecter", "Bigha", "Sq. ft."]
    static var FilterType = ["Featured", "Product A To Z", "Product Z To A", "Price Low To High", "Price High To Low"]
    static var SortType = ["Latest", "Popular"]
}

//App setting
enum AppSetting {
//    "UGA" // Univia galaxy partner
//    "UFA" // Univia farmer app
    
    static let AppCode = "Univia.UFA.06bdc8fb52386e69a9258574e7f325c0"
    static let AppId = "Univia.UFA.194e1181a179dc386bfdd1f0e5cdf287"
    static let AppName = "UFA"
    static let DeviceId = UIDevice.current.identifierForVendor!.uuidString
    static let DeviceType = "iOS"
    static let CurrencySybols = "₹ "
    static let NumberOfDigit = 2
    static let KMDigit = 1
    static let FeetDigit = 2
    static let SetMarqueeLabelTime = 7.0
    static var FCMTokenString = "Device Token simulator"
}

enum AppKeys: String {
    case GoogleMapKey = "AIzaSyD7oq-sqNcyM1TrJHjkEcw2mqaUhrLlnhM"
//    case RazorpayKey = "rzp_test_4vUFu4whz3SExf"
    case RazorpayKey = "rzp_live_i5N7F5A9aWt0pY"
    
    case WeatherKey = "4cb131e12591438f9fe43510241705"
}

//enum AppLabel {
//    static var arrLanguageLabelList: LanguageLabelsModel?
//    
//}

enum AppType: String {
    case UFAAgro = "UFAAgro"
    case UFAHome = "UFAHome"
}
//enum cropGlobleIDArray {
//    static var cropIDArrayGloble = NSMutableArray()
//    static var resultCropListModel: CropListDataModel?
//}

enum StoreLink{
    static var firebaseAppVersion = ""
    static var isAvailable = ""
    static var showPoupup = ""
    static var deleteAccount = 0
//    static let itunesAppleCom = "itms-apps://itunes.apple.com/app/000000"
    static let itunesAppleCom = "itms-apps://itunes.apple.com/app/6448461568"
 
}
struct NavigationTitle {
    
    static let Home = "Home"
    static let Product = "Product"
    static let Category = "Category"
    static let Brand = "Brand"
    static let Profile = "Profile"
    static let Order = "Order"
    static let Doctor = "Doctor"
    static let Blog = "Blog"
    static let Other = "Other"
    
}
struct NavigationBrandCategory{
    static var CategoryId = ""
    static var BrandId = ""
    static var SubcategoryId = ""
    static var productID = ""
    static var orderID = ""
    static var questionID = ""
    static var BlogID = ""
   
}
struct DynamicLinkNavigationType {
    static var Doctor = "Doctor"
    static var Product = "Product"
    static var Blog = "Blog"
}

