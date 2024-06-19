//
//  Singleton.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 21/05/24.
//

import Foundation
import UIKit
import CoreLocation
class Singleton {
    
    static let sharedInstance = Singleton()
    var arrCityWeatherData: WeatherListModel?
    var RegisterId: Int?
    var EditProfileData:EditProfileModel?
    var networkStatus = ""
    var storyId : Int?
    var verifyOTPDATA:verifyOTPModel?
}

