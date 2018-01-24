//
//  BaseUIButton.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/13/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUIButton: UIButton, FontDesignable, CornerDesignable, BorderDesignable, MaskDesignable, FillDesignable {

    @IBInspectable open var fontNameTheme:String? = DefaultConfig.shared.defaultFontName {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontColorTheme:String? = DefaultConfig.shared.defaultButtonFontColor  {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontSizeTheme:String? = DefaultConfig.shared.defaultFontSize  {
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontColorSelectedTheme: String? = DefaultConfig.shared.defaultButtonSelectedFontColor {
        didSet {
            configureSelectedFont();
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

    
    // MARK: - MaskDesignable
    open var maskType: MaskType = .none {
        didSet {
            configureMask(previousMaskType: oldValue)
            configureBorder()
            
        }
    }
    
    /// The mask type used in Interface Builder. **Should not** use this property in code.
    @IBInspectable var _maskType: String? {
        didSet {
            maskType = MaskType(string: _maskType)
        }
    }
    
    private var _titleKeys:[UInt:String] = [UInt:String]();
    override open func setTitle(_ title: String?, for state: UIControlState) {
        if let key:String = title , key.hasPrefix("#") == true{
            _titleKeys[state.rawValue] = key;  // holding key for using later
            super.setTitle(TextManager.text(forKey: key), for: state);
        } else {
            super.setTitle(title, for: state);
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
        configureMask(previousMaskType: maskType);
        configureCornerRadius();
        configureBorder();
        
        let states:[UIControlState] = [.normal, .selected, .highlighted, .disabled]
        
        for state in states {
            if let txt:String = self.title(for: state), txt.hasPrefix("#") == true {
                self.setTitle(txt, for: state);
            } else if let txtKey:String = _titleKeys[state.rawValue] {
                self.setTitle(txtKey, for: state);
            }
        }
    }

}
