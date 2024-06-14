//
//  DeleteStoryModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 14/06/24.
//

import Foundation
import ObjectMapper

struct DeleteStoryModel : Mappable {
    var status : Bool?
    var statusMessage : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
    }

}
