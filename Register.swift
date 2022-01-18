//
//  Register.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/19/21.
//

import Foundation

struct Register: Encodable{
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case password = "Password"
    }
}


