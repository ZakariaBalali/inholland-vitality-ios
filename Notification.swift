//
//  Notification.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/1/22.
//

import Foundation

struct NotificationResponse: Decodable {
    var results: [NotificationResult] = []
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let count = container.count {
            for _ in 0..<(count) {
                let result = try container.decode(NotificationResult.self)
                results.append(result)
            }
        }
    }
}


class NotificationResult: Decodable, Identifiable{
    let id: String
    let userId: String
    let toUser: String
    let notificationType: Int
    let timeOfNotification: String
    let fullNameSender: String
    let profilePictureSender: String?
    var isFollowing: Bool?
    let timelinePostId: String?
    let challengeId: String?
    enum CodingKeys: String, CodingKey {
        case id = "notificationId"
        case userId = "userId"
        case toUser = "toUser"
        case notificationType = "notificationType"
        case timeOfNotification = "timeOfNotification"
        case fullNameSender = "fullNameSender"
        case profilePictureSender = "profilePictureSender"
        case isFollowing = "isFollowing"
        case timelinePostId = "timelinePostId"
        case challengeId = "challengeId"
    }
}
