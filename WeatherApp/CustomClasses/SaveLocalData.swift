//
//  SaveLocalData.swift
//  Jhumru_ios
//
//  Created by Nikunj on 12/27/23.
//

import Foundation
import UIKit

func saveUserData(userData: verifyOTPModel, forKey defaultName: String = userDefaultsKeys.userdata.rawValue) {  // or forKey defaultName: String = dataKey
    //Convert a model object to a JSON string:
    let JSONString = userData.toJSONString(prettyPrint: true)

    guard let data = try? NSKeyedArchiver.archivedData(withRootObject: JSONString ?? "", requiringSecureCoding: false) else { return }
    UserDefaults.standard.set(data, forKey: defaultName)
    UserDefaults.standard.synchronize()
}
func saveNotificationData(userData: verifyOTPModel, forKey defaultName: String = userDefaultsKeys.userdata.rawValue) {  // or forKey defaultName: String = dataKey
    //Convert a model object to a JSON string:
    let JSONString = userData.toJSONString(prettyPrint: true)

    guard let data = try? NSKeyedArchiver.archivedData(withRootObject: JSONString ?? "", requiringSecureCoding: false) else { return }
    UserDefaults.standard.set(data, forKey: defaultName)
    UserDefaults.standard.synchronize()
}
func getUserData(forKey defaultName: String = userDefaultsKeys.userdata.rawValue) -> verifyOTPModel? {  // or forKey defaultName: String = dataKey
    guard let data = UserDefaults.standard.data(forKey: defaultName) else { return nil }
    guard let userData = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? String else { return nil }

    //Convert a JSON string to a model object:
    let user = verifyOTPModel(JSONString: userData)
    return user
}
//func saveCustomerUserData(userData: CustomerUserModel, forKey defaultName: String = userDefaultsKeys.CustomerUserdata.rawValue) {  // or forKey defaultName: String = dataKey
//    //Convert a model object to a JSON string:
//    let JSONString = userData.toJSONString(prettyPrint: true)
//
//    guard let data = try? NSKeyedArchiver.archivedData(withRootObject: JSONString ?? "", requiringSecureCoding: false) else { return }
//    UserDefaults.standard.set(data, forKey: defaultName)
//    UserDefaults.standard.synchronize()
//}
//
//func getCustomerUserData(forKey defaultName: String = userDefaultsKeys.CustomerUserdata.rawValue) -> CustomerUserModel? {  // or forKey defaultName: String = dataKey
//    guard let data = UserDefaults.standard.data(forKey: defaultName) else { return nil }
//    guard let userData = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? String else { return nil }
//
//    //Convert a JSON string to a model object:
//    let user = CustomerUserModel(JSONString: userData)
//    return user
//}
func removeUserDefaultsKey(key: String){
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}
//MARK: - User token
func saveString(strin: String, key: String){
    UserDefaults.standard.set(strin, forKey: key)
    UserDefaults.standard.synchronize()
}
func saveboolean(bool: Bool, key: String){
    UserDefaults.standard.set(bool, forKey: key)
    UserDefaults.standard.synchronize()
}

//func getString(key: String) -> String {
//    if let token = UserDefaults.standard.object(forKey: key) as? String {
//        return token
//    }
//    return ""
//}
func getString(key: String) -> String {
    if let token = UserDefaults.standard.object(forKey: key) as? String {
        return token
    }
    return ""
}

func getBoolean(key: String) -> String {
    if let token = UserDefaults.standard.object(forKey: key) as? String {
        return token
    }
    return ""
}
var selectedStartDate = ""
var selectedEndDate = ""
