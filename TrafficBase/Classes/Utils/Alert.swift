//
//  Alert.swift
//  BaseProject
//
//  Created by Waqas Ali on 01/02/2018.
//  Copyright © 2018 Waqas Ali. All rights reserved.
//

import UIKit

public class Alert {
    
    private init(){
        
    }
    
    
    
    static func showMsg(title : String = "Notification", msg : String , btnActionTitle : String? = "Okay" ) -> Void{
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
           
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    
    static func showWithCompletion(title : String = "Notification", msg : String , btnActionTitle : String? = "Okay" , completionAction: @escaping () -> Void ) -> Void{
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            completionAction()
        }
        alertController .addAction(alertAction)
       
       Alert.showOnWindow(alertController)
    }
    
    
    static func showWithTwoActions(title : String , msg : String , okBtnTitle : String , okBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void) -> Void{
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: okBtnTitle, style: .default, handler: { (action) in
            
            okBtnAction()
        })
        
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(doneAction)
        
        alertController .addAction(cancelAction)
        
       Alert.showOnWindow(alertController)
}
    
    static func showWithThreeActions( title : String , msg : String , FirstBtnTitle : String , FirstBtnAction: @escaping () -> Void , SecondBtnTitle : String , SecondBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void ) -> Void{
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let firstBtnAction = UIAlertAction(title: FirstBtnTitle, style: .default, handler: { (action) in
            
            FirstBtnAction()
        })
        
        
        let secondBtnAction = UIAlertAction(title: SecondBtnTitle, style: .default, handler: { (action) in
            
            SecondBtnAction()
        })
        
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(firstBtnAction)
        alertController .addAction(secondBtnAction)
        alertController .addAction(cancelAction)
        
      
    
        Alert.showOnWindow(alertController)
        
    }
    
    private static func showOnWindow(_ alert : UIAlertController) {
        
         UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
}
