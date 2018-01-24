//
//  AFRequest.swift
//  FABaseProject
//
//  Created by Fahad Ajmal on 01/11/2017.
//  Copyright © 2017 M.Fahad Ajmal. All rights reserved.
//

import Foundation
import Alamofire

struct AFRequest {
    //MARK: constant and variable
    struct serviceURL {
        static let userLogin: String = "users"
        static let userFileUpload: String = "users"
    }
    
    //shared Instance
    static let shared = AFRequest()
}

//MARK: Param Types

//simple param
struct AFRequestParam {
    var endpoint: String = ""
    var params: [String : AnyObject]?
    var headers: [String : String]?
    var method: HTTPMethod
}

//param with image
struct AFRequestParamWithImage {
    var endpoint: String = ""
    var params: [String : AnyObject]?
    var headers: [String : String]?
    var method: HTTPMethod
    var images: [UIImage]
}

//MARK: declare methods
extension AFRequest {
    
    //login
    func loginParam(_ email: String, password: String) -> AFRequestParam {
        
        let headers: [String : String]? = [:]
        
        let parameters = [
            "email": email,
            "password": password,
            ] as [String : AnyObject]
        
        let param = AFRequestParam(endpoint: AFRequest.serviceURL.userLogin, params: parameters, headers: headers, method: .get)
        
        return param
    }
    
    //file upload
    func fileUploadParam(_ userId: String, images:[UIImage]) -> AFRequestParamWithImage {
        
        let headers: [String : String]? = [:]
        
        let parameters = [
            "userId": userId,
            ] as [String : AnyObject]
        
        let param = AFRequestParamWithImage(endpoint: AFRequest.serviceURL.userFileUpload, params: parameters, headers: headers, method: .post, images: images)
        
        return param
    }
}
