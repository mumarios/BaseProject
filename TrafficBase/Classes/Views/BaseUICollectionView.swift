//
//  BaseUICollectionView.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/16/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUICollectionView: UICollectionView, FillDesignable {

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
    

}
