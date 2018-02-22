//
//  ViewController.swift
//  TrafficBase
//
//  Created by FaraziOS on 01/24/2018.
//  Copyright (c) 2018 FaraziOS. All rights reserved.
//

import UIKit
import TrafficBase

class ViewController: UIViewController {

    @IBOutlet weak var btnTest: BaseUIButton!
    @IBOutlet weak var textField: BaseUITextField!
    
    //@IBOutlet weak var textView: BaseUITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textField.leftImage = UIImage.init(named: "Agree-Sel")
        //textField.leftImage = nil
        textField.leftImage = UIImage.init(named: "Agree-Sel")
        
        //textView.placeholderText = "Testing placeholder"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

