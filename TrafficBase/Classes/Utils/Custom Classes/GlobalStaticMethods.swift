//
//  GlobalStaticMethods.swift
//  BaseProject
//
//  Created by Muhammad Umar on 12/19/17.
//  Copyright © 2017 Waqas Ali. All rights reserved.
//

import UIKit
import Foundation

class GlobalStaticMethods: NSObject {
    
    static func isJailBrokeDevice()->Bool{
        #if arch(i386) || arch(x86_64)
            debugPrint("Simulator")
            return false
        #else
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(fileURLWithPath: "cydia://package/com.example.package")) // canOpenURL(URL(string:"cydia://package/com.example.package”)!)
                
            {
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do
            {
                try stringToWrite.write(toFile:"/;;private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                //Device is jailbroken
                return true
            }catch
            {
                return false
            }
        #endif        
    }
}
