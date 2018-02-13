//
//  AFRequestParam.swift
//  BaseProject
//
//  Created by Fahad Ajmal on 31/01/2018.
//  Copyright © 2018 M.Fahad Ajmal. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//request param for call
public struct AFParam {
    public var endpoint: String = ""
    public var params: [String : AnyObject]?
    public var headers: [String : String]?
    public var method: HTTPMethod
    public var images: [UIImage]?
    
    public init(endpoint:String, params: [String : AnyObject], headers: [String : String], method: HTTPMethod, images: [UIImage]) {
        self.endpoint = endpoint
        self.params = params
        self.headers = headers
        self.method = method
        self.images = images
    }
}
