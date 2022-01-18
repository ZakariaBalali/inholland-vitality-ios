//
//  Greeting.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/14/22.
//

import Foundation

 func getGreeting() -> String {
       let hour = Calendar.current.component(.hour, from: Date())

       switch hour {
       case 0..<6:
           return String(localized: "good_night")
       case 4..<12:
           return String(localized: "good_morning")
       case 12..<18:
           return String(localized: "good_afternoon")
       case 18..<24:
           return String(localized: "good_evening")
       default:
           break
       }
       return "Hello"
   }
