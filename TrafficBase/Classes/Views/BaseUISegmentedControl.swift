//
//  BaseUISegmentedControl.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/20/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUISegmentedControl: UISegmentedControl, FontDesignable, FillDesignable, TintDesignable {

    private var _titleKeys:[Int:String] = [Int:String]();
    
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

    // MARK: - FillDesignable
    @IBInspectable open var fillThemeColor: String? {
        didSet {
            configureFillColor();
        }
    }
    
    
    @IBInspectable open var opacity: CGFloat = CGFloat.nan {
        didSet {
            configureOpacity();
        }
    }
    
    // MARK: - TintDesignable
    @IBInspectable open var tintThemeColor: String? {
        didSet {
            configureTintColor();
        }
    }
    
    override open func setTitle(_ title: String?, forSegmentAt segment: Int) {
        if let key:String = title , key.hasPrefix("#") == true {
            
            _titleKeys[segment] = key;  // holding key for using later
            super.setTitle(TextManager.text(forKey: key), forSegmentAt: segment);
        } else {
            super.setTitle(title, forSegmentAt: segment);
        }
    }
    
    //MARK: - Initializers
    open override func awakeFromNib() {
        super.awakeFromNib();
        configureInspectableProperties();
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews();
        configureAfterLayoutSubviews();
        
    }
    
    // MARK: - Private
    fileprivate func configureInspectableProperties() {
        
    }
    
    fileprivate func configureAfterLayoutSubviews() {
        configureFont();
        
        for i:Int in 0..<numberOfSegments {
            if let key:String = _titleKeys[i] {
                self.setTitle(key, forSegmentAt: i);
            }
        }

    }
}
