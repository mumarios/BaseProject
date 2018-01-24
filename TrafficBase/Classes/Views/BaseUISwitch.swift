//
//  BaseUISwitch.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/20/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUISwitch: UISwitch {
    
    open class BaseUISwitch: UISwitch {
        
        //MARK: - Properties
        @IBInspectable open var onColorStyle:String? = nil {
            didSet {
                self.onTintColor = ColorManager.color(forKey: onColorStyle);
            }
        }
        
        @IBInspectable open var thumbColorStyle:String? = nil {
            didSet {
                self.thumbTintColor = ColorManager.color(forKey: thumbColorStyle);
            }
        }
        
        //MARK: - Overridden Methods
        override open func awakeFromNib() {
            super.awakeFromNib()
            
            self.configureView()
        }
        
        func configureView() {
            if let onCStyle = self.onColorStyle {
                self.onColorStyle = onCStyle;
            }
            
            if let thumbCStyle = self.thumbColorStyle {
                self.thumbColorStyle = thumbCStyle;
            }
        }
        
    }
    
}
