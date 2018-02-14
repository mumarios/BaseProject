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

    @IBOutlet weak var textField: BaseUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = "Testing"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

