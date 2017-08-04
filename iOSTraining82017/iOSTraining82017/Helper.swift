//
//  Helper.swift
//  iOSTraining82017
//
//  Created by Dung on 8/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
enum EmailValidationResult {
    case EmailValid
    case EmailEmpty
    case EmailInvalid
}
class Helper {
    //MARK: Validate email format
    
    
    static func isValidEmail(email: String) -> (EmailValidationResult) {
        
        // Check empty string
        guard email.characters.count > 0 else {
            return EmailValidationResult.EmailEmpty
        }
        // Check email format
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        guard emailTest.evaluate(with: email) else {
            return EmailValidationResult.EmailInvalid
        }
        
        return EmailValidationResult.EmailValid
    }
    //MARK: Validate email and password length
    
    static func isValidTextLength(email: String, password: String) -> Bool {
        return email.characters.count > 6 && password.characters.count > 6
    }
    
}
