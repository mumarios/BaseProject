//
//  BaseManager.swift
//  Framework
//
//  Created by Faraz Hussain Siddiqui on 8/7/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

class BaseManager: NSObject {
    
    private static var _sharedInstance: BaseManager = BaseManager();
    private var isIpad:Bool = false;
    
    class var sharedInstance: BaseManager {
        get {
            return self._sharedInstance;
        }
    }
    
    private lazy var fileName: String = {
        self.isIpad = DesignUtility.isIPad;
        return  (self.isIpad == true && self is FontManager) ? "\(type(of: self))_iPad" : "\(type(of: self))";
    }()

    
    private var _dictData:NSMutableDictionary?
    internal var dictData:NSDictionary? {
        get {
            return _dictData;
        }
    }
    
    public class func objectForKey<T>(_ aKey: String?) -> T? {
        return self.sharedInstance.objectForKey(aKey);
    }
    
    internal func objectForKey<T>(_ aKey: String?) -> T? {
        guard (aKey != nil) else {
            return nil;
        }
        
        return _dictData?.object(forKey: aKey!) as? T;
        
    }
    
    override init() {
        
        super.init();
        
        self.setupPlistFile();
    }
    
    private func setupPlistFile() {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            _dictData = NSMutableDictionary(contentsOf: URL(fileURLWithPath: path));
        }
        else {
            assertionFailure("Unable to load plist \(fileName)")
        }
    }
    
}
