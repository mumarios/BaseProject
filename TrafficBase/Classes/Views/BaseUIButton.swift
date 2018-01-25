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
    
    private var fontColor : UIColor? = nil
    private var fontSelectedColor : UIColor? = nil
    
    @IBInspectable open var fontColorTheme:String? = DefaultConfig.shared.defaultButtonFontColor  {
        
        didSet {
            
            fontColor = (fontColorTheme != nil && !(fontColorTheme?.isEmpty)!) ? ColorManager.color(forKey: fontColorTheme!) : UIColor.black;
            fontSelectedColor = fontColor
            self.setTitleColor(fontColor, for: .normal);
            //--wwconfigureFont();
        }
    }
    
    @IBInspectable open var fontSizeTheme:String? = DefaultConfig.shared.defaultFontSize  {
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontColorSelectedTheme: String? = DefaultConfig.shared.defaultButtonSelectedFontColor {
        didSet {
            
            fontSelectedColor = (fontColorSelectedTheme != nil && !(fontColorSelectedTheme?.isEmpty)!) ? ColorManager.color(forKey: fontColorSelectedTheme!) : fontColor;
            
            
            //--ww  configureSelectedFont();
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
    
    
    private var bgColor : UIColor? = nil
    private var bgSelectedColor : UIColor? = nil
    // MARK: - FillDesignable
    @IBInspectable open var fillThemeColor: String? {
        didSet {
            
            let fillColor = UIColor.color(forKey: fillThemeColor);
            if fillColor == nil {
                #if DEBUG
                    assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
                #endif
                return;
            }else{
                bgColor = fillColor
                self.backgroundColor = bgColor
            }
            //--ww configureFillColor();
        }
    }
    
    @IBInspectable var bgHighlightedColor: String? {
        didSet{
            
            let fillColor = UIColor.color(forKey: bgHighlightedColor);
            if fillColor == nil {
                #if DEBUG
                    assertionFailure("Fill color for key : \(String(describing: bgHighlightedColor)) not found\n")
                #endif
                return;
            }else{
                bgSelectedColor = fillColor
            }
            
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
        
        self.addTarget(self, action: #selector(self.highlight), for: .touchDown)
        self.addTarget(self, action: #selector(self.unhighlight), for: .touchUpInside)
        self.addTarget(self, action: #selector(self.unhighlight), for: .touchDragOutside)
        self.addTarget(self, action: #selector(self.unhighlight), for: .touchCancel)
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
    
    @objc func unhighlight(){
        guard bgColor != nil else {
            
            return;
        }
        
        self.setTitleColor(fontColor, for: .normal);
        self.backgroundColor = bgColor
        
    }
    
    @objc func highlight(){
        
        guard bgSelectedColor != nil else {
            
            return;
        }
        
        self.setTitleColor(fontSelectedColor, for: .normal);
        self.backgroundColor = bgSelectedColor
    }
    
}
