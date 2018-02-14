//
//  String+Extensions.swift
//  BaseProject
//
//  Created by Waqas Ali on 29/12/2017.
//  Copyright © 2017 Waqas Ali. All rights reserved.
//

import Foundation

public extension String {
   
    public func toDouble() -> Double? {
        return Double(self)
    }
    
    public func toFloat() -> Float? {
        return Float(self)
    }
   
    public func toInt() -> Int? {
        return Int(self)
    }
   
    public var localized: String {
        // the; translators team, they don’t deserve comments
        return localoizedFromPlist.sharedInstance.localize(string: self)
    }
    
    // Validate if the string is empty
    public func isEmptyStr()->Bool {
        return (self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "");
    }
    
    // Validate if the email is correct
    public func isValidEmail()->Bool {
        let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: self);
    }
    
    // Validate if the url is correct
    public func isValidUrl() -> Bool {
        let regexURL: String = "(http://|https://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regexURL)
        return predicate.evaluate(with: self)
    }
    
    // Validate if given input is numeric
    public func isNumeric() -> Bool {
        return Double(self) != nil;
    }
    
    // Validate if string has minimum characters
    public func isValidForMinChar(noOfChar:Int) -> Bool {
        return (self.utf16.count >= noOfChar);
    }
    
    // Validate if string has less than or equal to maximum characters
    public func isValidForMaxChar(noOfChar:Int) -> Bool {
        return (self.utf16.count <= noOfChar);
    }
    
    // Validate the string for given regex
    public func isValidForRegex(regex:String) -> Bool {
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self);
    }
    
    //extension for getting the domain name from a string
    public func getDomain() -> String? {
        guard let url = URL(string: self) else { return nil }
        return url.host
    }
    
}
