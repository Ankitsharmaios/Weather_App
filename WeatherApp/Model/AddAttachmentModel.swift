//
//  AddAttachmentModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/06/24.
//

import Foundation
import ObjectMapper

struct AddAttachmentModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var result : [String]?
    var mediaLink : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        result <- map["Result"]
        mediaLink <- map["MediaLink"]
    }

}
