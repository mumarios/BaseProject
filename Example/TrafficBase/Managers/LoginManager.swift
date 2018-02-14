//
//  LoginManager.swift
//  FABaseProject
//
//  Created by Fahad Ajmal on 19/12/2017.
//  Copyright © 2018 M.Fahad Ajmal. All rights reserved.
//

import Foundation
import TrafficBase

class LoginManager: AFManagerProtocol {
    
    var isLoginTrue = false
    var dataList: [String] = []

    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        self.isLoginTrue = false
        
        //request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            let status = response.dictionary!["status"]
            
            //check success case from server
            if status == "success" {
                self.isLoginTrue = true
            }
            completion()
        }) { (error) in

            completion()
        }
    }
}

