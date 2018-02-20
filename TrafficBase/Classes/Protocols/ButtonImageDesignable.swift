//
//  ButtonImageDesignable.swift
//  Alamofire
//
//  Created by Faraz Hussain Siddiqui on 2/20/18.
//

import Foundation

public protocol ButtonImageDesignable: class {
    
    var applyHorizontalValues: Bool { get set }
    var titleOnLeft: Bool { get set }
    var keepTextInCenter: Bool { get set }
    var spaceValue: CGFloat { get set }
}


public extension ButtonImageDesignable where Self: BaseUIButton {
    
    public func configureButtonImage() {
        
        setTitleAndImageCorners();
    }
    
    fileprivate func setTitleAndImageCorners() {
        
        if imageView != nil, applyHorizontalValues == true {
            if titleOnLeft == true {
                
                let rightEdge = (frame.size.width - (imageView?.frame.size.width)!)
                let leftEdge = ((titleLabel?.frame.size.width)! - (frame.size.width + (imageView?.frame.size.width ?? 0)))
                
                imageEdgeInsets = UIEdgeInsets(top: 0, left: rightEdge - (spaceValue), bottom: 0, right: spaceValue)
                if keepTextInCenter == false {
                    titleEdgeInsets = UIEdgeInsets(top: 0, left:leftEdge + spaceValue, bottom: 0, right: -spaceValue)
                }
                else {
                    titleEdgeInsets = UIEdgeInsets(top: 0, left:-(imageView?.frame.size.width ?? 0), bottom: 0, right: 0)
                }
                
            }
            else {
                let rightEdge = (frame.size.width - (imageView?.frame.size.width)!)
                let leftEdge = ((titleLabel?.frame.size.width)! - (frame.size.width - (imageView?.frame.size.width ?? 0)))
                
                if keepTextInCenter == false {
                    titleEdgeInsets = UIEdgeInsets(top: 0, left:-spaceValue, bottom: 0, right: leftEdge + spaceValue)
                }
                else {
                    titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
                imageEdgeInsets = UIEdgeInsets(top: 0, left: spaceValue, bottom: 0, right: rightEdge - spaceValue)
                
            }
        }
        
    }
}
