//
//  DateConverter.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/7/21.
//

import Foundation

struct DateConverter {
    
    static func convertTimeDate(of timestamp: String) -> String{
        if(timestamp.count == 27){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
            let publishDate = formatter.date(from: timestamp)
            formatter.dateFormat = "dd MMMM yyyy"
            if let date = publishDate {
                return formatter.string(from: date)
            }
            return String(localized: "unknown_date")
        }
        else if(timestamp.count == 19){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let publishDate = formatter.date(from: timestamp)
            formatter.dateFormat = "dd MMMM yyyy"
            if let date = publishDate {
                return formatter.string(from: date)
            }
            return String(localized: "unknown_date")
        }
        else{
            return String(localized: "unknown_date")
        }
    }
    
    
    static func convertTime(of timestamp: String) -> String {
        if(timestamp.count == 33){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
            
            let publishDate = formatter.date(from: timestamp)
            
            if(publishDate == nil){
                return String(localized: "unknown_date")
            }else{
                
                
                let secondsAgo = Int(Date().timeIntervalSince(publishDate!))
                
                if secondsAgo < 60 {
                    return "\(secondsAgo) " + String(localized: "seconds_ago")
                }
                
                else if secondsAgo < 60 * 60 {
                    return "\(secondsAgo / 60) " + String(localized: "minutes_ago")
                }
                
                else if secondsAgo < 60 * 60 * 24 {
                    
                    return "\(secondsAgo / 60 / 60) " + String(localized: "hours_ago")
                }
                else if secondsAgo < 60 * 60 * 24 * 7{
                    if((secondsAgo / 60 / 60 / 24) == 1){
                        return "\(secondsAgo / 60 / 60 / 24 ) " + String(localized: "day_ago")
                    }
                    else{
                        
                        
                        return "\(secondsAgo / 60 / 60 / 24 ) " + String(localized: "days_ago")
                    }
                }
                if((secondsAgo / 60 / 60 / 24 / 7) == 1){
                    return "\(secondsAgo / 60 / 60 / 24 / 7) " + String(localized: "week_ago")
                    
                }else{
                    return "\(secondsAgo / 60 / 60 / 24 / 7) " + String(localized: "weeks_ago")
                    
                }
            }
        }
        else if(timestamp.count == 32){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            
            let publishDate = formatter.date(from: timestamp)
            
            if(publishDate == nil){
                return String(localized: "unknown_date")
            }else{
                
                
                let secondsAgo = Int(Date().timeIntervalSince(publishDate!))
                
                if secondsAgo < 60 {
                    return "\(secondsAgo) " + String(localized: "seconds_ago")
                }
                
                else if secondsAgo < 60 * 60 {
                    return "\(secondsAgo / 60) " + String(localized: "minutes_ago")
                }
                
                else if secondsAgo < 60 * 60 * 24 {
                    
                    return "\(secondsAgo / 60 / 60) " + String(localized: "hours_ago")
                }
                else if secondsAgo < 60 * 60 * 24 * 7{
                    if((secondsAgo / 60 / 60 / 24) == 1){
                        return "\(secondsAgo / 60 / 60 / 24 ) " + String(localized: "day_ago")
                    }
                    else{
                        
                        
                        return "\(secondsAgo / 60 / 60 / 24 ) " + String(localized: "days_ago")
                    }
                }
                if((secondsAgo / 60 / 60 / 24 / 7) == 1){
                    return "\(secondsAgo / 60 / 60 / 24 / 7) " + String(localized: "week_ago")
                    
                }else{
                    return "\(secondsAgo / 60 / 60 / 24 / 7) " + String(localized: "weeks_ago")
                    
                }
            }
        }
        else{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
            
            let publishDate = formatter.date(from: timestamp)
            
            if(publishDate == nil){
                return String(localized: "unknown_date")
            }else{
                
                
                let secondsAgo = Int(Date().timeIntervalSince(publishDate!))
                
                if secondsAgo < 60 {
                    return "\(secondsAgo) " + String(localized: "seconds_ago")
                }
                
                else if secondsAgo < 60 * 60 {
                    return "\(secondsAgo / 60) " + String(localized: "minutes_ago")
                }
                
                else if secondsAgo < 60 * 60 * 24 {
                    
                    return "\(secondsAgo / 60 / 60) " + String(localized: "hours_ago")
                }
                else if secondsAgo < 60 * 60 * 24 * 7{
                    if((secondsAgo / 60 / 60 / 24) == 1){
                        return "\(secondsAgo / 60 / 60 / 24 ) " + String(localized: "day_ago")
                    }
                    else{
                        
                        
                        return "\(secondsAgo / 60 / 60 / 24 ) " + String(localized: "days_ago")
                    }
                }
                if((secondsAgo / 60 / 60 / 24 / 7) == 1){
                    return "\(secondsAgo / 60 / 60 / 24 / 7) " + String(localized: "week_ago")
                    
                }else{
                    return "\(secondsAgo / 60 / 60 / 24 / 7) " + String(localized: "weeks_ago")
                    
                }
            }
            
        }
        
    }
    
    
}

