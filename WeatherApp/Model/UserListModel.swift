//
//  UserListModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 17/06/24.
//

import Foundation
import ObjectMapper

struct UserListModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var error : [String]?
    var result : [UserResultModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct UserResultModel : Mappable {
    var id : Int?
    var image : String?
    var phoneno : String?
    var name : String?
    var about : String?
    var deviceToken : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        image <- map["Image"]
        phoneno <- map["Phoneno"]
        name <- map["Name"]
        about <- map["About"]
        deviceToken <- map["DeviceToken"]
    }

}
