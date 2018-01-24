//
//  BaseLayoutConstraint.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/13/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseLayoutConstraint: NSLayoutConstraint {
    
    override open func awakeFromNib() {
    
        super.awakeFromNib();
        self.constant = DesignUtility.convertToRatio(constant, sizedForIPad: false, sizedForNavi:false);
        
        self.constant = DesignUtility.getValueFromRatio(80)
        
    }
}
