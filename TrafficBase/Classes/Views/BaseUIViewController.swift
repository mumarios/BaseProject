//
//  BaseUIViewController.swift
//  TrafficFramework
//
//  Created by Faraz Hussain Siddiqui on 8/16/17.
//  Copyright © 2017 Faraz Hussain Siddiqui. All rights reserved.
//

import UIKit

open class BaseUIViewController: UIViewController {
    
    private var _titleKey:String?;
    
    static func getViewControllerFromStoryboard(_ storyboardName:String!, _ vcStoryboardId:String!) -> UIViewController{
        
        //        if storyboardName == nil || vcStoryboardId == nil{
        //
        //        }
        
        let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: vcStoryboardId)
        return vc
    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

