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
    var truncateTail: Bool { get set }
}


public extension ButtonImageDesignable where Self: BaseUIButton {
    
    public func configureButtonImage() {
        
        setTitleAndImageCorners();
    }
    
    fileprivate func setTitleAndImageCorners() {
        
        if imageView != nil, applyHorizontalValues == true {
            
            if let font = self.titleLabel?.font {
                let fontAttributes = [NSAttributedStringKey.font: font]
                var myText = self.currentTitle
                var size = (myText)?.size(withAttributes: fontAttributes)
                if (size?.width)! > self.frame.width * 0.7 {
                    while (size?.width)! > (self.frame.width * 0.7) {
                        if truncateTail == true {
                            myText = myText?.truncated(limit: (myText?.count)! - 5, position: .tail, leader: "...")
                        }
                        else {
                            myText = myText?.truncated(limit: (myText?.count)! - 5, position: .head, leader: "...")
                        }
                        size = (myText)?.size(withAttributes: fontAttributes)
                    }
                    
                    self.setTitle(myText, for: .normal)
                }
            }
            
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

extension String {
    enum TruncationPosition {
        case head
        case middle
        case tail
    }
    
    func truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "...") -> String {
        guard self.count > limit else { return self }
        
        switch position {
        case .head:
            return leader + self.suffix(limit)
        case .middle:
            let headCharactersCount = Int(ceil(Float(limit - leader.count) / 2.0))
            
            let tailCharactersCount = Int(floor(Float(limit - leader.count) / 2.0))
            
            return "\(self.prefix(headCharactersCount))\(leader)\(self.suffix(tailCharactersCount))"
        case .tail:
            return self.prefix(limit) + leader
        }
    }
}

