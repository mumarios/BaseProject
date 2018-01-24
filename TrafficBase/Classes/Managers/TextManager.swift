//
//  TextManager.swift
//  Framework
//
//  Created by Faraz Hussain Siddiqui on 8/7/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

class TextManager: BaseManager {
    private static var _sharedInstance: TextManager = TextManager();
    
    class override var sharedInstance: TextManager {
        get {
            return self._sharedInstance;
        }
    }
    
    public class func text(forKey key: String) -> String {
        return TextManager.sharedInstance.text(forKey: key);
    }
    
    private func text(forKey key: String) -> String {
        if let rtnTxt:String = (self.objectForKey(key.trimmingCharacters(in: CharacterSet(charactersIn: "#")))) {
            return rtnTxt.replacingOccurrences(of: "\\n", with: "\n");
        } else {
            return  key;
        }
    }
}
