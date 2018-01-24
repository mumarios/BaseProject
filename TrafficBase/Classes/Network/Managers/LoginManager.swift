//
//  LoginManager.swift
//  FABaseProject
//
//  Created by Fahad Ajmal on 19/12/2017.
//  Copyright © 2017 M.Fahad Ajmal. All rights reserved.
//

import Foundation

class LoginManager: NSObject {
    
    var isLoginTrue = false
    
    func api(completion: @escaping () -> Void) {
        AFNetwork.shared.apiRequest(AFRequest.shared.loginParam("user", password: "password"), success: { (response) in
            
            self.isLoginTrue = true
            completion()
        }) { (error) in
            
            self.isLoginTrue = false
            completion()
        }
    }
}

