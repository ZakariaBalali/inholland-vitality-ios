//
//  User.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/1/21.
//

import Foundation

struct SearchResponse: Decodable {
    var results: [SearchResult] = []
    
    init(from decoder: Decoder) throws {
        results = try [SearchResult](from: decoder)
    }
}

struct SearchResult: Decodable, Identifiable {
    let id: String
    let fullName: String?
    let jobTitle: String?
    let location: String?
    let profilePicture: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case fullName = "fullName"
        case jobTitle = "jobTitle"
        case location = "location"
        case profilePicture = "profilePicture"
    }
    
    
    
}

struct PointsResponse: Decodable{
    var results: [PointsResult] = []
    
    init(from decoder: Decoder) throws {
        results = try [PointsResult](from: decoder)
    }
}

struct PointsResult: Decodable, Identifiable, Hashable {
    let id: String
    let fullName: String?
    let points: Int
    let profilePicture: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case fullName = "fullName"
        case points = "points"
        case profilePicture = "profilePicture"
    }
}

struct UserResponse: Decodable, Identifiable {
    let id: String
    let firstName: String?
    let lastName: String?
    let jobTitle: String?
    let location: String?
    let description: String?
    let challenges: [Challenge]?
    let followers: [Followers]?
    let profilePicture: String?
    let points: Int?
    let following: Bool?
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case firstName = "firstName"
        case lastName = "lastName"
        case jobTitle = "jobTitle"
        case location = "location"
        case description = "description"
        case challenges = "challenges"
        case followers = "followers"
        case profilePicture = "profilePicture"
        case points = "points"
        case following = "following"
    }
    
    
    
}

struct Challenge: Decodable, Identifiable{
    let id: String
    let progress: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "challengeId"
        case progress = "challengeProgress"
    }
}

struct Followers: Decodable, Identifiable{
    let id: String?
    enum CodingKeys: String, CodingKey{
        case id = "userFollowerId"
    }
}



