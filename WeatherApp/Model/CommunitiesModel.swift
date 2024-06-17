//
//  CommunitiesModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 17/06/24.
//

import Foundation
import ObjectMapper
struct CommunitiesListModel: Mappable {
    var _id: String?
    var adminId: String?
    var adminName: String?
    var createdAt: String?
    var groupIcon: String?
    var groupName: String?
    var lastmessage: String?
    var lastmessagedate: String?
    var lastmessagetime: String?
    var lastmessagetype: String?
    var mediatype: String?
    var mediaurl: String?
    var members: [MembersListModel]?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        _id <- map["_id"]
        adminId <- map["adminId"]
        adminName <- map["adminName"]
        createdAt <- map["createdAt"]
        groupIcon <- map["groupIcon"]
        groupName <- map["groupName"]
        lastmessage <- map["lastmessage"]
        lastmessagedate <- map["lastmessagedate"]
        lastmessagetime <- map["lastmessagetime"]
        lastmessagetype <- map["lastmessagetype"]
        mediaurl <- map["mediaurl"]
        members <- map["members"]
    }
}

struct MembersListModel: Mappable {
    var about: String?
    var deviceToken: String?
    var id: Int?
    var image: String?
    var name: String?
    var phoneno: String?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        about <- map["about"]
        deviceToken <- map["deviceToken"]
        id <- map["id"]
        image <- map["image"]
        name <- map["name"]
        phoneno <- map["phoneno"]
    }
}
