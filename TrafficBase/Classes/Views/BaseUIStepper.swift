//
//  BaseUIStepper.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/20/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUIStepper: UIStepper, TintDesignable {

    // MARK: - TintDesignable
    @IBInspectable open var tintThemeColor: String? {
        didSet {
            configureTintColor();
        }
    }

}
