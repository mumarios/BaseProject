//
//  ButtonImageDesignable.swift
//  Alamofire
//
//  Created by Faraz Hussain Siddiqui on 2/20/18.
//

import Foundation

public protocol ButtonImageDesignable: class {
    
    var titleOnLeft: Bool { get set }
    var adjustImageOnly: Bool { get set }
    var spaceValue: CGFloat { get set }
}


public extension ButtonImageDesignable where Self: BaseUIButton {
    
    public func configureButtonImage() {
        setTitleAndImageCorners();
    }
    
    fileprivate func setTitleAndImageCorners() {
        
        if (titleOnLeft == true) {
            
            if (adjustImageOnly == false) {
                var spacingTitle =  CGFloat ( self.frame.size.width - (self.imageView!.frame.size.width + self.titleLabel!.frame.size.width + self.frame.height * 0.5)) + self.frame.height * 0.5
                
                if spaceValue > 0 {
                    
                    spacingTitle = CGFloat (self.frame.size.width - (self.imageView!.frame.size.width + self.titleLabel!.frame.size.width + DesignUtility.convertToRatio(spaceValue)))
                }
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacingTitle )
            }
            var spacingImage = CGFloat (self.frame.size.width  - (self.imageView!.frame.size.width + self.frame.height * 0.5 ))  - DesignUtility.convertToRatio(6)
            
            if spaceValue > 0 {
                
                spacingImage = CGFloat (self.frame.size.width - (self.imageView!.frame.size.width + self.titleLabel!.frame.size.width + DesignUtility.convertToRatio(spaceValue)))
            }
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0, spacingImage, 0, 0);
        }
        else {
            
            if (adjustImageOnly == false) {
                
                var spacingTitle =  CGFloat ( self.frame.size.width - (self.imageView!.frame.size.width + self.titleLabel!.frame.size.width +  self.frame.height * 0.5))  - self.frame.height * 0.5
                
                
                if spaceValue > 0 {
                    
                    spacingTitle =  CGFloat (self.frame.size.width - (self.imageView!.frame.size.width + self.titleLabel!.frame.size.width + DesignUtility.convertToRatio(spaceValue)))
                }
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0, spacingTitle, 0, 0 )
            }
            
            var spacingImage : CGFloat = 0.0;
            
            if spaceValue > 0 {
                
                spacingImage = CGFloat (self.frame.size.width - (self.imageView!.frame.size.width + self.titleLabel!.frame.size.width + DesignUtility.convertToRatio(spaceValue)))
            }
            else {
                spacingImage = CGFloat ( self.frame.size.width - (self.imageView!.frame.size.width + self.titleLabel!.frame.size.width + self.frame.height * 0.5) )  - self.frame.height * 0.5
            }
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacingImage);
            
        }
        
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
}
