//
//  TimelineComment.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/7/21.
//

import Foundation

struct TimelineCommentResponse: Decodable {
    var results: [TimelineCommentResult] = []
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let count = container.count {
            for _ in 0..<(count) {
                let result = try container.decode(TimelineCommentResult.self)
                results.append(result)
            }
        }
    }
}


class TimelineCommentResult: Decodable, Identifiable{
    let id: String
    let timelinePostId: String
    let text: String
    let userId: String
    let timestamp: String
    let profilePicture: String?
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "commentId"
        case timelinePostId = "timelinePostId"
        case text = "text"
        case userId = "userId"
        case timestamp = "timestamp"
        case profilePicture = "imageUrl"
        case fullName = "fullName"
    }
}

struct Comment : Encodable{
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        
    }
}

class CommentOnPostResponse: Decodable, Identifiable{
    let timelinePostId: String
    let text: String
    let userId: String
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case timelinePostId = "timelinePostId"
        case text = "text"
        case userId = "userId"
        case timestamp = "timestamp"
        
    }
}


