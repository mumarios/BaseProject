//
//  BaseUILabel.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/10/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUILabel: UILabel, FontDesignable, CornerDesignable, BorderDesignable, FillDesignable {

    // MARK: - FontDesignable
    @IBInspectable open var fontNameTheme:String? = DefaultConfig.shared.defaultFontName {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontColorTheme:String? = DefaultConfig.shared.defaultFontColor  {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontSizeTheme:String? = DefaultConfig.shared.defaultFontSize  {
        didSet {
            configureFont();
        }
    }

    // MARK: - CornerDesignable
    @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
        didSet {
            configureCornerRadius();
        }
    }
    
    open var cornerSides: CornerSides  = .allSides {
        didSet {
            configureCornerRadius();
        }
    }
    
    //NOTE:- Possible values topleft, topright, bottomleft, bottomright
    @IBInspectable var _cornerSides: String? {
        didSet {
            cornerSides = CornerSides(rawValue: _cornerSides);
        }
    }
    
    // MARK: - BorderDesignable
    open var borderType: BorderType  = .solid {
        didSet {
            configureBorder();
        }
    }
    
    //NOTE:- Possible values solid, dash
    @IBInspectable var _borderType: String? {
        didSet {
            borderType = BorderType(string: _borderType);
        }
    }
    
    @IBInspectable open var borderThemeColor: String? {
        didSet {
            configureBorder();
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
        didSet {
            configureBorder();
        }
    }
    
    open var borderSides: BorderSides  = .AllSides {
        didSet {
            configureBorder();
        }
    }
    
    //NOTE:- Possible values Top, Right, Bottom, Left
    @IBInspectable var _borderSides: String? {
        didSet {
            borderSides = BorderSides(rawValue: _borderSides);
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

    
    private var _textKey: String?
    override open var text: String? {
        get {
            return super.text;
        }
        
        set {
            if let key:String = newValue , key.hasPrefix("#") == true {
                _textKey = key;
                
                super.text = TextManager.text(forKey: key);
            } else {
                super.text = newValue;
            }
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
        configureCornerRadius();
    }
    
    fileprivate func configureAfterLayoutSubviews() {
        configureCornerRadius();
        configureBorder();
        configureFont();
        
        if let txt:String = self.text , txt.hasPrefix("#") == true {
            self.text = txt;
        } else if _textKey != nil {
            self.text = _textKey;
        }
    }

}
