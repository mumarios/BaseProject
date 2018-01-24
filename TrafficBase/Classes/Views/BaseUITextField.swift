//
//  BaseUITextField.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/10/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUITextField: UITextField, FontDesignable, CornerDesignable, BorderDesignable, PlaceholderDesignable, SideImageDesignable, FillDesignable {

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

    // MARK: - PlaceholderDesignable
    @IBInspectable open var placeholderThemeColor: String? {
        didSet {
            configurePlaceholderColor();
        }
    }
    
    // MARK: - SideImageDesignable
    @IBInspectable open var leftImage: UIImage? {
        didSet {
            configureImages();
        }
    }
    
    @IBInspectable open var leftImageLeftPadding: CGFloat = CGFloat.nan {
        didSet {
            configureImages();
        }
    }
    
    @IBInspectable open var leftImageRightPadding: CGFloat = CGFloat.nan {
        didSet {
            configureImages();
        }
    }
    
    @IBInspectable open var leftImageTopPadding: CGFloat = CGFloat.nan {
        didSet {
            configureImages();
        }
    }
    
    @IBInspectable open var rightImage: UIImage? {
        didSet {
            configureImages();
        }
    }
    
    @IBInspectable open var rightImageLeftPadding: CGFloat = CGFloat.nan {
        didSet {
            configureImages();
        }
    }
    
    @IBInspectable open var rightImageRightPadding: CGFloat = CGFloat.nan {
        didSet {
            configureImages();
        }
    }
    
    @IBInspectable open var rightImageTopPadding: CGFloat = CGFloat.nan {
        didSet {
            configureImages();
        }
    }

    private var _placeholderKey:String?
    override open var placeholder: String? {
        get {
            return super.placeholder;
        }
        
        set {
            guard let key:String = newValue else {
                _placeholderKey = nil;
                super.placeholder = newValue;
                return;
            }
            
            let newPlaceHolder:String;
            
            if (key.hasPrefix("#") == true) {
                _placeholderKey = key;
                
                newPlaceHolder = TextManager.text(forKey: key);
            } else {
                _placeholderKey = nil;
                
                newPlaceHolder = key;
            }
            
            super.placeholder = newPlaceHolder;
            
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
        configureImages();
    }
    
    fileprivate func configureAfterLayoutSubviews() {
        configureCornerRadius();
        configureBorder();
    }

}
