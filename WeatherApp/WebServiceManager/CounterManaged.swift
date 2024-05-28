//
//  CounterManaged.swift
//  UniviaFarmer
//
//  Created by Nikunj on 3/19/23.
//
//
//import Foundation
//import UIKit
//
//extension UIViewController {
//    
//    func getCartItemCount(){
//        DataManager.shared.getCartList() { [weak self] (result) in
//            switch result {
//            case .success(let appCartListModel):
////                saveString(strin: "\(appCartListModel.Result?.count ?? 0)", key: "CartCount")
//                
//                
//                var cartItemCount = 0
//                               for i in appCartListModel.Result ?? []{
//                                   cartItemCount = cartItemCount + (Int(i.Quantity ?? "") ?? 0)
//                               }
//                               print("latest count is \(cartItemCount)")
//                
//                print("latest count is \(cartItemCount ?? 0)")
//
//                saveString(strin: "\(Int(cartItemCount ?? 0))", key: userDefaultsKeys.CartCount.rawValue)
//                
//                
//                //saveString(strin: "\(appCartListModel.Result?.count ?? 0)", key: userDefaultsKeys.CartCount.rawValue)
//            case .failure(let apiError):
//                print("Error ", apiError.localizedDescription)
//                APPLICATION_DELEGATE.genarateUserToken { statuscode in
//                    if statuscode {
//                        // Call API
//                        self?.getCartItemCount()
//                    }
//                }
//            }
//        }
//    }
//    
//    func getNotificationCount(){
//        DataManager.shared.getNotificationDetail() { [weak self] (result) in
//            switch result {
//            case .success(let appNotificationListModel):
//                saveString(strin: "\(appNotificationListModel.Notification?.count ?? 0)", key: userDefaultsKeys.NotificationCount.rawValue)
//            case .failure(let apiError):
//                print("Error ", apiError.localizedDescription)
//                APPLICATION_DELEGATE.genarateUserToken { statuscode in
//                    if statuscode {
//                        // Call API
//                        self?.getNotificationCount()
//                    }
//                }
//            }
//        }
//    }
//}

import UIKit
import Foundation
struct StoreLink {
    static var showPopupt = ""
    static var iOSLastVersion = ""
    static var systemVersionCheckIOS = ""
    static let itunesAppleCom = "itms-apps://itunes.apple.com/app/6499210085" //"https://apps.apple.com/us/app/"
    static var iOSDeleteAccout = ""
    static let systemVersion = (UIDevice.current.systemVersion as NSString).floatValue
}
