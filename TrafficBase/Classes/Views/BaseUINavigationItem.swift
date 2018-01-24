//
//  BaseUINavigationItem.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/16/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUINavigationItem: UINavigationItem {
    
    private var _titleKey:String?;
    override open var title: String? {
        get {
            return super.title;
        }
        
        set {
            if let key:String = newValue , key.hasPrefix("#") == true {
                _titleKey = key;  
                
                super.title = TextManager.text(forKey: key);
            } else {
                super.title = newValue;
            }
        }
    }
    
    public override init(title: String) {
        super.init(title: title);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib();
        
        self.updateView();
    }
    
    
    func updateView() {
        if let txt:String = self.title , txt.hasPrefix("#") == true {
            self.title = txt;
        } else if _titleKey != nil {
            self.title = _titleKey;
        }
    }

}
