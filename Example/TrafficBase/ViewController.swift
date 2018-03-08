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
        btnTest.fontNameTheme = "fontLight"
        let k:UIFont = getFont(fontNameTheme: "fontDefault", fontSizeTheme: "sizeXSmall")!
        //FontManager.constant(forKey: <#T##String?#>)
        print(k)
        textField.leftImage = UIImage.init(named: "Agree-Sel")
        
        //textField.leftImage = nil
        textField.rightImage = UIImage.init(named: "Agree-Sel")
        
        //textView.placeholderText = "Testing placeholder"
    }
    
    func getFont(fontNameTheme:String?, fontSizeTheme:String?)->UIFont? {
        let fName = (fontNameTheme != nil && !(fontNameTheme?.isEmpty)!) ? FontManager.constant(forKey: fontNameTheme!) : "Helvetica";
        let fontSize = (fontSizeTheme != nil && !(fontSizeTheme?.isEmpty)!) ? FontManager.style(forKey: fontSizeTheme!) : 25;
        
        let resizedFontSize = DesignUtility.getFontSize(fSize: CGFloat(fontSize))
        
        let fnt = UIFont.init(name: fName!, size: resizedFontSize);
        return fnt;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

