//
//  VerifyOTPModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 23/05/24.
//

import Foundation
import ObjectMapper

struct verifyOTPModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var result : OTPResultModel?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        result <- map["Result"]
    }

}
struct OTPResultModel : Mappable {
    var registerId : Int?
    var name : String?
    var phoneNo : String?
    var about : String?
    var hashToken : String?
    var image : String?
    var twoFactorStatus : String?
    var userstatus : String?
    var restricteStatus : String?
    var restricteType : String?
    var restricteTime : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        registerId <- map["RegisterId"]
        name <- map["Name"]
        phoneNo <- map["PhoneNo"]
        about <- map["About"]
        hashToken <- map["HashToken"]
        image <- map["Image"]
        twoFactorStatus <- map["TwoFactorStatus"]
        userstatus <- map["userstatus"]
        restricteStatus <- map["restricteStatus"]
        restricteType <- map["restricteType"]
        restricteTime <- map["restricteTime"]
    }

}
