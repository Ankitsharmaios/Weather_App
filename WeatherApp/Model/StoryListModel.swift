//
//  StoryListModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 29/05/24.
//

import Foundation
import ObjectMapper

struct StoryListModel : Mappable {
    var status : Bool?
    var statusMessage : String?
    var error : [String]?
    var result : [StoryResultModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["Status"]
        statusMessage <- map["StatusMessage"]
        error <- map["Error"]
        result <- map["Result"]
    }

}

struct StoryResultModel : Mappable {
    var userId : Int?
    var userName : String?
    var userImage : String?
    var media : [MediaModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        userId <- map["UserId"]
        userName <- map["UserName"]
        userImage <- map["UserImage"]
        media <- map["Media"]
    }

}

struct MediaModel : Mappable {
    var Id : Int?
    var uRL : String?
    var date : String?
    var time : String?
    var storyType : String?
    var text : String?
    var textBackground : String?
    var textstyle : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        Id <- map["Id"]
        uRL <- map["URL"]
        date <- map["Date"]
        time <- map["Time"]
        storyType <- map["StoryType"]
        text <- map["Text"]
        textBackground <- map["TextBackground"]
        textstyle <- map["Textstyle"]
    }

}
