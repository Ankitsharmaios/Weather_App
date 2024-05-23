//
//  RegisterModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 23/05/24.
//

import Foundation
import ObjectMapper

struct RegisterModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var isRegistered : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        isRegistered <- map["isRegistered"]
    }

}
