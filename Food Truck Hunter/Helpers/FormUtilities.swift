//
//  FormUtilities.swift
//  Food Truck Hunter
//
//  Created by Sue Vang on 9/29/20.
//

import Foundation

class FormUtilities {
    
    static func validateEmail(_ email : String) -> Bool {
        let regexPattern = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        return emailTest.evaluate(with: email)
    }
    
    static func validatePassword(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "((?=.*\\d)(?=.*[A-Z])(?=.*\\W).{8,})")
        return passwordTest.evaluate(with: password)
    }
    
    static func showHintLabel(_ value : Bool) -> Double {
        return value ? 1 : 0
    }
}
