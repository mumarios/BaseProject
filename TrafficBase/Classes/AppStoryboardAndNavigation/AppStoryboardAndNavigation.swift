//
//  AppStoryboardAndNavigation.swift
//  BaseProject
//
//  Created by Adil Anwer on 12/28/17.
//  Copyright © 2017 Waqas Ali. All rights reserved.
//

import Foundation
import UIKit

public extension StoryBoardHandler where Self: UIViewController {
    // Code
    
    public static func loadVC() -> Self{
        
        return viewController(viewControllerClass: self, storyBoardName: self.myStoryBoard)
    }
    
    // Instanitating an specific storyboard
    static func instanceStoryBoard(storyboardName : String) -> UIStoryboard {
        
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    // Instanitating an specific view controller from storyboard
    public static func viewController<T : UIViewController>(viewControllerClass : T.Type, storyBoardName : String,  function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instanceStoryBoard(storyboardName:storyBoardName).instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(storyBoardName) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    // MARK: - Show(push) given view controller with given parametters
    public func show<T: UIViewController>(viewcontrollerInstance:UIViewController , configure: ((T) -> Void)? = nil) {
        
        configure?(viewcontrollerInstance as! T)
        show(viewcontrollerInstance, sender: self)
    }
    
    // MARK: - Instanitate the view controller object and Present it with given parametters if required
    
    public func presentViewController<T: UIViewController>(viewControllerInstance:UIViewController, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle, completion: ((T) -> Void)? = nil) {
        
        //        let viewControllerInstance = viewcontrollerInstance.instantiate(fromAppStoryboard: viewcontrollerInstance.myStoryBoard)
        
        //        if let modalPresentationStyle = modalPresentationStyle {
        viewControllerInstance.modalPresentationStyle = modalPresentationStyle
        //        }
        
        //        configure?(viewControllerInstance as! T)
        present(viewControllerInstance, animated: animated) {
            
            completion?(viewControllerInstance as! T)
        }
    }
    
    
    // MARK: - Push given view controller with given parametters and custom navigation controller
    public func navigateWithCustomNavigation<T: UIViewController>(viewControllerInstance:UIViewController, navController:UINavigationController? , configure: ((T) -> Void)? = nil) {
        
        configure?(viewControllerInstance as! T)
        
        if  navController != nil{
            
            navController?.pushViewController(viewControllerInstance, animated: true)
        }
        else{
            
            print("App delegate navigation controller has not been initialized")
        }
    }
    
    // MARK: - Pop to specific view controller already in the stack
    public func popViewToViewController<T: UIViewController>(navigationController:UINavigationController ,animation : Bool, viewControllerClass:T.Type) {
        
        //        if let _ = self as? StoryBoardHandler{
        
        let navCon = navigationController
        
        let controllers = navCon.viewControllers
        let countControllers = controllers.count
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            
            return
        }
        
        //for i in 0..<countControllers {
        _ = controllers.enumerated().flatMap { i, object in
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", i)
                
                _ = navCon.popToViewController((controllers[i]), animated: true)
                return;
            }
        }
        //        }
    }
}

public extension UIViewController {
    
    // MARK: - Storyboard id to use in instantiating of view controller
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        return "\(self)"
    }
}

// MARK: - Protocol for setting storyboard name
public protocol StoryBoardHandler {
    
    static var myStoryBoard : String {get}
}

