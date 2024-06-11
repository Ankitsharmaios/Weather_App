//
//  ChatModel.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 11/06/24.
//
import Foundation
import ObjectMapper

struct ChatModel: Mappable {
    var date: String?
    var id: String?
    var indexId: String?
    var isDeleted: String?
    var mediatype: String?
    var mediaurl: String?
    var message: String?
    var messageStatus: String?
    var receiverID: String?
    var receiverImage: String?
    var receiverName: String?
    var receiverToken: String?
    var replyMessage: String?
    var replySendUserId: String?
    var sendType: String?
    var senderFcmToken: String?
    var senderImage: String?
    var senderName: String?
    var sentID: String?
    var time: String?
    var unReadMessageCount: String?
    var videoCallLink: String?
    var videoCallStatus: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        date <- map["date"]
        id <- map["id"]
        indexId <- map["indexId"]
        isDeleted <- map["isDeleted"]
        mediatype <- map["mediatype"]
        mediaurl <- map["mediaurl"]
        message <- map["message"]
        messageStatus <- map["messageStatus"]
        receiverID <- map["receiverID"]
        receiverImage <- map["receiverImage"]
        receiverName <- map["receiverName"]
        receiverToken <- map["receiverToken"]
        replyMessage <- map["replyMessage"]
        replySendUserId <- map["replySendUserId"]
        sendType <- map["sendType"]
        senderFcmToken <- map["senderFcmToken"]
        senderImage <- map["senderImage"]
        senderName <- map["senderName"]
        sentID <- map["sentID"]
        time <- map["time"]
        unReadMessageCount <- map["unReadMessageCount"]
        videoCallLink <- map["videoCallLink"]
        videoCallStatus <- map["videoCallStatus"]
    }
}
