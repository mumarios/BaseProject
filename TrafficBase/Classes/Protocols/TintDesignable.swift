//
//  TintDesignable.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/20/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

public protocol TintDesignable: class {
    var tintThemeColor: String? { get set }
   
}

extension TintDesignable where Self: UIView {
   
    internal func configureTintColor() {
        guard tintThemeColor != nil, tintThemeColor?.isEmpty == false else {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: tintThemeColor)) not found\n")
            #endif
            return;
        }
        let fillColor = UIColor.color(forKey: tintThemeColor);
        if fillColor == nil {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: tintThemeColor)) not found\n")
            #endif
            return;
        }
        
        self.tintColor = fillColor
    }
}
