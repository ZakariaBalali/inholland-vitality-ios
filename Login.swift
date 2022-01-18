//
//  Login.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/19/21.
//

struct Login: Encodable{
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case password = "Password"
    }
}

struct LoginResponse: Decodable {
    let AccessToken: String
    let RefreshToken: String
    enum CodingKeys: String, CodingKey {
        case AccessToken = "accessToken"
        case RefreshToken = "refreshToken"
    }
}
