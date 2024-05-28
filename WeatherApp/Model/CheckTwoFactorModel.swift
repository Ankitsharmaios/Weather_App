//
//  CheckTwoFactorModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/05/24.
//

import Foundation
import ObjectMapper

struct CheckTwoFactorModel : Mappable {
    var status : Bool?
    var statusMessage : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
    }

}