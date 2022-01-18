//
//  EmailValidator.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/11/22.
//

import Foundation
import SwiftUI
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: testStr)
    return result
}
