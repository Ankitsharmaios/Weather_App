//
//  EditProfileModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 24/05/24.
//

import Foundation
import ObjectMapper

struct EditProfileModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var result : EditProfileResultModel?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        result <- map["Result"]
    }

}
struct EditProfileResultModel : Mappable {
    var registerId : Int?
    var hashToken : String?
    var name : String?
    var about : String?
    var userImage : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        registerId <- map["RegisterId"]
        hashToken <- map["HashToken"]
        name <- map["Name"]
        about <- map["About"]
        userImage <- map["UserImage"]
    }

}
