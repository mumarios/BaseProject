//
//  String+Extensions.swift
//  BaseProject
//
//  Created by Waqas Ali on 29/12/2017.
//  Copyright © 2017 Waqas Ali. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return Double(self)
    }
    func toFloat() -> Float? {
        return Float(self)
    }
    func toInt() -> Int? {
        return Int(self)
    }
    var localized: String {
        // the; translators team, they don’t deserve comments
        return localoizedFromPlist.sharedInstance.localize(string: self)
    }
    
    // Validate if the string is empty
    func isEmptyStr()->Bool {
        return (self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "");
    }
    
    // Validate if the email is correct
    func isValidEmail()->Bool {
        let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: self);
    }
    
    // Validate if the url is correct
    func isValidUrl() -> Bool {
        let regexURL: String = "(http://|https://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regexURL)
        return predicate.evaluate(with: self)
    }
    
    // Validate if given input is numeric
    func isNumeric() -> Bool {
        return Double(self) != nil;
    }
    
    // Validate if string has minimum characters
    func isValidForMinChar(noOfChar:Int) -> Bool {
        return (self.utf16.count >= noOfChar);
    }
    
    // Validate if string has less than or equal to maximum characters
    func isValidForMaxChar(noOfChar:Int) -> Bool {
        return (self.utf16.count <= noOfChar);
    }
    
    // Validate the string for given regex
    func isValidForRegex(regex:String) -> Bool {
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self);
    }
    
}
