//
//  LiveChatModel.swift
//  WeatherApp
//
//  Created by Mahesh_MacMini on 28/05/24.
//

import Foundation
import ObjectMapper
struct LiveChatDataModel:Mappable{
 
    var date:String?
    var id:String?
    var indexId:String?
    var isDeleted:String?
    var message:String?
    var messageStatus:String?
    var receiverphone:String?
    var receiverID:String?
    var receiverImage:String?
    var receiverName:String?
    var receiverToken:String?
    var receiverabout:String?
    var sentabout:String?
    var senderFcmToken:String?
    var senderImage:String?
    var senderName:String?
    var sentID:String?
    var sentphone:String?
    var time:String?
    var unReadMessageCount:String?
    var videoCallLink:String?
    var videoCallStatus:String?
    var replySendUserId:String?
    init?(map: ObjectMapper.Map) {
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        date <- map["date"]
        id <- map["id"]
        indexId <- map["indexId"]
        isDeleted <- map["isDeleted"]
        message <- map["message"]
        messageStatus <- map["messageStatus"]
        receiverabout <- map["receiverabout"]
        receiverphone <- map["receiverphone"]
        receiverID <- map["receiverID"]
        receiverImage <- map["receiverImage"]
        receiverName <- map["receiverName"]
        receiverToken <- map["receiverToken"]
        sentabout <- map["sentabout"]
        sentphone <- map["sentphone"]
        senderFcmToken <- map["senderFcmToken"]
        senderImage <- map["senderImage"]
        senderName <- map["senderName"]
        sentID <- map["sentID"]
        time <- map["time"]
        unReadMessageCount <- map["unReadMessageCount"]
        videoCallLink <- map["videoCallLink"]
        videoCallStatus <- map["videoCallStatus"]
        replySendUserId <- map["replySendUserId"]
    }
    
    
}
