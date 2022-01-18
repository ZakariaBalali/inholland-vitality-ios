//
//  Challenge.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import Foundation

struct ChallengeResponse: Decodable {
    var results: [ChallengeResult] = []
    
    init(from decoder: Decoder) throws {
        results = try [ChallengeResult](from: decoder)
    }
}


class ChallengeResult: Decodable, Identifiable{
    let id: String
    let title: String
    let challengeType: Int
    let description: String
    let startDate: String
    let endDate: String
    let location: String
    let points: Int
    var challengeProgress: Int
    let totalSubscribers: Int
    let imageLink: String?
    let videoLink: String?
    enum CodingKeys: String, CodingKey {
        case id = "challengeId"
        case title = "title"
        case challengeType = "challengeType"
        case description = "description"
        case startDate = "startDate"
        case endDate = "endDate"
        case location = "location"
        case points = "points"
        case challengeProgress = "challengeProgress"
        case totalSubscribers = "totalSubscribers"
        case imageLink = "imageLink"
        case videoLink = "videoLink"
    }
}

