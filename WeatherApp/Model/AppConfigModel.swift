//
//  AppConfigModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 12/06/24.
//

import Foundation
import ObjectMapper

struct AppConfigModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var result : AppConfigResultModel?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        result <- map["Result"]
    }

}
struct AppConfigResultModel : Mappable {
    var appName : String?
    var appColor : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        appName <- map["AppName"]
        appColor <- map["AppColor"]
    }

}
