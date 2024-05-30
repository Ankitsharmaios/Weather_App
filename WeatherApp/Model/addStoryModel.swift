//
//  addStoryModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 30/05/24.
//

import Foundation
import ObjectMapper

struct addStoryModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var result : [String]?
    var mediaLink : String?
    var storyType : String?
    var text : String?
    var textBackground : String?
    var textstyle : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        result <- map["Result"]
        mediaLink <- map["MediaLink"]
        storyType <- map["StoryType"]
        text <- map["Text"]
        textBackground <- map["TextBackground"]
        textstyle <- map["Textstyle"]
    }

}
