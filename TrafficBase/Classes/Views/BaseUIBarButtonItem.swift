//
//  BaseUIBarButtonItem.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/16/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUIBarButtonItem: UIBarButtonItem, FontDesignable {
    
    // MARK: - FontDesignable
    @IBInspectable open var fontNameTheme:String? = DefaultConfig.shared.defaultFontName {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontSizeTheme:String? = DefaultConfig.shared.defaultFontSize  {
        didSet {
            configureFont();
        }
    }
    
    private var _titleKey:String?;
    open override var title: String? {
        set {
            if let key:String = newValue , key.hasPrefix("#") == true{
                
                _titleKey = key;  // holding key for using later
                super.title = TextManager.text(forKey: key);
            } else {
                super.title = newValue;
            }
        }
        
        get {
            return super.title;
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib();
        
        configureFont();
        
        if let txt:String = self.title , txt.hasPrefix("#") == true {
            self.title = txt;
        } else if _titleKey != nil {
            self.title = _titleKey
        }
    }
}

