//
//  UserListManager.swift
//  BaseProject
//
//  Created by Fahad Ajmal on 01/02/2018.
//  Copyright © 2018 Waqas Ali. All rights reserved.
//

import Foundation
import TrafficBase

class UserListManager: AFManagerProtocol {
    
    var isSuccess = false
    var arrList: [Users]?
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        self.arrList = []
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            let model = UserListModel.init(json: response)
            
            //check success case from server
            if model.status == "success" {
                self.isSuccess = true
                self.arrList = model.users!
            }
            completion()
        }) { (error) in
            
            completion()
        }
    }
    
    func numberOfItemsToDisplay() -> Int {
        return arrList?.count ?? 0
    }
    
    func userNameToDisplay(for indexPath: IndexPath) -> String {
        return arrList?[indexPath.row].username ?? ""
    }
    
    func userEmailToDisplay(for indexPath: IndexPath) -> String {
        return arrList?[indexPath.row].email ?? ""
    }
    
    func userAgeToDisplay(for indexPath: IndexPath) -> Int {
        return arrList?[indexPath.row].age ?? 0
    }
}

