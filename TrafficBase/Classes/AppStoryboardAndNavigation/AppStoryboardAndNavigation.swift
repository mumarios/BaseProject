//
//  AppStoryboardAndNavigation.swift
//  BaseProject
//
//  Created by Adil Anwer on 12/28/17.
//  Copyright © 2017 Waqas Ali. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Enum for writting multiple storyboards which we are using inside our application
enum AppStoryboard : String {
    
    // As enum is extends from String the its case name is also its value
    case Home
    //    case Main , More
    
    // Instanitating an specific storyboard
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    // Instanitating an specific view controller from storyboard
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    // Instanitating an initial view controller inside the storyboard
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}

// MARK: - Enum to access variables written in main app delegate
enum AppDelegateConstants{
    
    static var appDelegateNavigation:UINavigationController?{
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //return (appDelegate.navigationController)!
        
        return nil;
    }
}

extension StoryBoardHandler where Self: UIViewController {
    // Code
    
    // MARK: - Viewcontroller intialization
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    static func loadVC() -> Self
    {
        
        return self.myStoryBoard.viewController(viewControllerClass:self)
        
    }
    
    // MARK: - Show(push) given view controller with given parametters
    func show<T: UIViewController>(viewcontrollerInstance:UIViewController , configure: ((T) -> Void)? = nil) {
        
        configure?(viewcontrollerInstance as! T)
        show(viewcontrollerInstance, sender: self)
    }
    
    // MARK: - Instanitate the view controller object and Show(push) it with given parametters if required
    func show<T: UIViewController>(configure: ((T) -> Void)? = nil) {
        
        let viewControllerInstance = Self.instantiate(fromAppStoryboard: Self.myStoryBoard)
        configure?(viewControllerInstance as! T)
        show(viewControllerInstance, sender: self)
    }
    
    // MARK: - Instanitate the view controller object and Present it with given parametters if required
    
    func present<T: UIViewController>(animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        
        let viewControllerInstance = Self.instantiate(fromAppStoryboard: Self.myStoryBoard)
        
        if let modalPresentationStyle = modalPresentationStyle {
            viewControllerInstance.modalPresentationStyle = modalPresentationStyle
        }
        
        configure?(viewControllerInstance as! T)
        present(viewControllerInstance, animated: animated) {
            completion?(viewControllerInstance as! T)
        }
    }
    
    // MARK: - Push given view controller with given parametters and navigation controller of main app delegate
    func navigateFromAppDelegateNavigation<T: UIViewController>(configure: ((T) -> Void)? = nil) {
        
        let viewControllerInstance = Self.instantiate(fromAppStoryboard: Self.myStoryBoard)
        configure?(viewControllerInstance as! T)
        if AppDelegateConstants.appDelegateNavigation != nil{
            
            AppDelegateConstants.appDelegateNavigation?.pushViewController(viewControllerInstance, animated: true)
        }
        else{
            
            print("App delegate navigation controller has not been initialized")
        }
    }
    
    // MARK: - Push given view controller with given parametters and custom navigation controller
    func navigateWithCustomNavigation<T: UIViewController>(navController:UINavigationController? , configure: ((T) -> Void)? = nil) {
        
        let viewControllerInstance = Self.instantiate(fromAppStoryboard: Self.myStoryBoard)
        configure?(viewControllerInstance as! T)
        if  navController != nil{
            
            navController?.pushViewController(viewControllerInstance, animated: true)
        }
        else{
            
            print("App delegate navigation controller has not been initialized")
        }
    }
    
    // MARK: - Pop to root view controller of the application
    func popToRootViewControllerMain(animated: Bool) {
        
        AppDelegateConstants.appDelegateNavigation?.popToRootViewController(animated: animated)
    }
    
    // MARK: - Pop to specific view controller already in the stack
    func popViewToViewController<T: UIViewController>(animation : Bool, viewControllerClass:T.Type) {
        
        //        if let _ = self as? StoryBoardHandler{
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let navCon = appDelegate.navigationController
        
        let controllers = navCon?.viewControllers
        let countControllers = controllers?.count ?? 0
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            return
        }
        
        //for i in 0..<countControllers {
        _ = controllers?.enumerated().flatMap { i, object in
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", i)
                
                _ = navCon?.popToViewController((controllers?[i])!, animated: true)
                return;
            }
        }
        //        }
 */
    }
    
    // MARK: - Set main view controller of the application
    func setMainViewController(viewController : UIViewController){
        
        AppDelegateConstants.appDelegateNavigation?.viewControllers.removeAll()
        AppDelegateConstants.appDelegateNavigation?.viewControllers = [viewController]
    }
    
    func setRootViewControllerObj(controller : UIViewController , withAnimation animated : Bool){
        
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}

extension UIViewController {
    
    // MARK: - Storyboard id to use in instantiating of view controller
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        return "\(self)"
    }
}

// MARK: - Protocol for setting storyboard name
protocol StoryBoardHandler {
    
    static var myStoryBoard : AppStoryboard {get}
}
