//
//  Challenge.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import Foundation

struct TimelineResponse: Decodable {
    var results: [TimelineResult] = []
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let count = container.count {
            for _ in 0..<(count) {
                let result = try container.decode(TimelineResult.self)
                results.append(result)
            }
        }
    }
}


class TimelineResult: Decodable, Identifiable{
    let id: String
    let publishDate: String
    var countOfLikes: Int
    var countOfComments: Int
    var iLikedPost: Bool
    let text: String
    let userId: String
    let fullName: String
    let profilePicture: String?
    let imageUrl: String?
    enum CodingKeys: String, CodingKey {
        case id = "timelinePostId"
        case publishDate = "publishDate"
        case countOfLikes = "countOfLikes"
        case countOfComments = "countOfComments"
        case iLikedPost = "iLikedPost"
        case text = "text"
        case userId = "userId"
        case fullName = "fullName"
        case profilePicture = "profilePicture"
        case imageUrl = "imageUrl"
    }
}


struct LikersResponse: Decodable {
    var results: [LikersResult] = []
    
    init(from decoder: Decoder) throws {
        results = try [LikersResult](from: decoder)
    }
}


class LikersResult: Decodable, Identifiable{
    
    let id: String
    let timelinePostId: String
    let userId: String
    let fullName: String?
    let jobTitle: String?
    let location: String?
    let imageUrl: String?
    enum CodingKeys: String, CodingKey {
        case id = "likeId"
        case timelinePostId = "timelinePostId"
        case userId = "userId"
        case fullName = "fullName"
        case jobTitle = "jobTitle"
        case location = "location"
        case imageUrl = "profilePicture"
    }
}

struct TimelinePost : Encodable{
    let text: String?
    
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        
    }
}
struct TimelinePostResponse: Decodable {
    let id: String
    let publishDate: String
    let countOfLikes: Int
    let countOfComments: Int
    let iLikedPost: Bool
    let text: String
    let userId: String
    let fullName: String
    let profilePicture: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "timelinePostId"
        case publishDate = "publishDate"
        case countOfLikes = "countOfLikes"
        case countOfComments = "countOfComments"
        case iLikedPost = "iLikedPost"
        case text = "text"
        case userId = "userId"
        case fullName = "fullName"
        case profilePicture = "profilePicture"
        case imageUrl = "imageUrl"
    }
}
