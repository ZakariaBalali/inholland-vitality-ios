//
//  Profile.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import Foundation

struct Profile : Encodable{
    let firstName: String
    let lastName: String
    let jobTitle: String
    let location: String
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "Firstname"
        case lastName = "Lastname"
        case jobTitle = "JobTitle"
        case location = "Location"
        
    }
}

struct ProfileComplete : Encodable{
    let firstName: String
    let lastName: String
    let jobTitle: String
    let location: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "Firstname"
        case lastName = "Lastname"
        case jobTitle = "JobTitle"
        case location = "Location"
        case description = "Description"
        
    }
}
struct ProfileResponse: Decodable {
    let firstName: String
    let lastName: String
    let jobTitle: String
    let location: String
    let description: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
        case jobTitle = "jobTitle"
        case location = "location"
        case description = "description"
        case password = "password"
        
    }
}




