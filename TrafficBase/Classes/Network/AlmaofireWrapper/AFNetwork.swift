//
//  AFNetwork.swift
//  FABaseProject
//
//  Created by Fahad Ajmal on 01/11/2017.
//  Copyright © 2017 M.Fahad Ajmal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: Param Types

//simple param
public struct AFRequestParam {
    var endpoint: String = ""
    var params: [String : AnyObject]?
    var headers: [String : String]?
    var method: HTTPMethod
    
    public init(endpoint:String, params: [String : AnyObject], headers: [String : String], method: HTTPMethod) {
        self.endpoint = endpoint
        self.params = params
        self.headers = headers
        self.method = method
    }
}

//param with image
public struct AFRequestParamWithImage {
    var endpoint: String = ""
    var params: [String : AnyObject]?
    var headers: [String : String]?
    var method: HTTPMethod
    var images: [UIImage]
    
    public init(endpoint:String, params: [String : AnyObject], headers: [String : String], method: HTTPMethod, images: [UIImage]) {
        self.endpoint = endpoint
        self.params = params
        self.headers = headers
        self.method = method
        self.images = images
    }
}

public class AFNetwork: NSObject {
    
    //MARK: constant and variable
    //manager
    public var alamoFireManager : Alamofire.SessionManager!
    
    //network
    public var baseURL = DEFAULT_CONFIG.baseUrl
    public var commonHeaders: Dictionary<String, String> = [
        "Authorization" : "",
        "Accept" : "application/json"
    ]
    
    //spinner
    struct spinnerViewConfig {
        static let tag: Int = 98272
        static let color = UIColor.white
    }
    
    //progress view
    var progressLabel: UILabel?
    var progressView: UIProgressView?
    
    struct progressViewConfig {
        static let tag: Int = 98273
        static let color = UIColor.white
        static let labelColor = UIColor.red
        static let trackTintColor = UIColor.red
        static let progressTintColor = UIColor.green
    }
    
    //shared Instance
    public static let shared: AFNetwork = {
        let instance = AFNetwork()
        return instance
    }()
    
    // MARK: - : override
    override init() {
        alamoFireManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
        alamoFireManager.session.configuration.timeoutIntervalForRequest = 120
    }
    
    public func setupSSLPinning(_ fileNameInBundle: String) {
        
        // Set up certificates
        let pathToCert = Bundle.main.path(forResource: fileNameInBundle, ofType: "crt")
        let localCertificate = NSData(contentsOfFile: pathToCert!)
        let certificates = [SecCertificateCreateWithData(nil, localCertificate!)!]
        
        // Configure the trust policy manager
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: certificates,
            validateCertificateChain: true,
            validateHost: true
        )
        
        let serverTrustPolicies = [
            AFNetwork.shared.baseURL.getDomain() ?? AFNetwork.shared.baseURL : serverTrustPolicy
        ]
        
        alamoFireManager =
            Alamofire.SessionManager(
                configuration: URLSessionConfiguration.default,
                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
    }
}

// MARK: - Request
extension AFNetwork {
    
    //general request
    public func apiRequest(_ info: AFRequestParam, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        //request
        alamoFireManager.request(self.baseURL + info.endpoint, method: info.method, parameters: nil, encoding: JSONEncoding.default, headers: mergeWithCommonHeaders(info.headers)).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                
                let resJson = JSON(response.result.value!)
                debugPrint(resJson)
                success(resJson)
            }
            if response.result.isFailure {
                
                let error : Error = response.result.error!
                
                debugPrint("responseError: \(error)")
                failure(error)
            }
        }
    }
    
    //file upload
    func apiRequestUpload(_ info: AFRequestParamWithImage, success:@escaping (JSON?) -> Void, failure:@escaping (Error) -> Void) {
        
        let URL = try! URLRequest(url: self.baseURL + info.endpoint, method: info.method, headers: mergeWithCommonHeaders(info.headers))
        
        alamoFireManager.upload(multipartFormData: { (multipartFormData) in
            
            //multipart params
            if info.params != nil {
                
                for (key, value) in info.params! {
                    if let data = value.data(using: String.Encoding.utf8.rawValue) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
            
            //multipart images
            if info.images.count > 0 {
                for value in info.images {
                    let imageData = UIImagePNGRepresentation(value) as Data?
                    if imageData != nil {
                        multipartFormData.append(imageData!, withName: "image[]")
                    }
                }
            }
            
        }, with: URL, encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload
                    .uploadProgress { progress in
                        
                        //set progress view
                        self.setProgressProgress(Float(progress.fractionCompleted))
                        
                    }
                    .validate()
                    .responseJSON { response in
                        
                        //set progress view
                        self.setProgressProgress(1.0)
                        
                        switch response.result {
                        case .success(let value):
                            
                            debugPrint(value)
                            
                            if let result = response.result.value {
                                let resJson = JSON(result)
                                success(resJson)
                            }
                            else {
                                success(nil)
                            }
                            
                        case .failure(let responseError):
                            
                            debugPrint("responseError: \(responseError)")
                            failure(responseError)
                        }
                }
            case .failure(let encodingError):
                failure(encodingError)
            }
        })
    }
}

// MARK: - Progress and spinner methods
extension AFNetwork {
    
    public func showProgressView(_ customView: UIView?) {
        
        var window = customView
        
        if (window == nil) {
            window = returnTopWindow()
        }
        if window?.viewWithTag(progressViewConfig.tag) != nil {
            return
        }
        
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.tag = progressViewConfig.tag
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        
        let progressContainer = UIView()
        progressContainer.translatesAutoresizingMaskIntoConstraints = false
        progressContainer.backgroundColor = UIColor.clear
        
        progressLabel = UILabel()
        progressLabel?.translatesAutoresizingMaskIntoConstraints = false
        progressLabel?.textColor = progressViewConfig.labelColor
        progressLabel?.text = "Upload progress 0%"
        progressLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
        progressLabel?.adjustsFontSizeToFitWidth = true
        progressLabel?.textAlignment = .center
        progressContainer.addSubview(progressLabel!)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView?.translatesAutoresizingMaskIntoConstraints = false
        progressView?.progressTintColor = progressViewConfig.progressTintColor
        progressView?.trackTintColor = progressViewConfig.trackTintColor
        progressView?.progress = 0.0
        progressContainer.addSubview(progressView!)
        
        progressContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[progressView]-(10)-[progressLabel]|", options: [], metrics: nil, views: ["progressLabel" : progressLabel!, "progressView" : progressView!]))
        progressContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[progressView(200)]|", options: [], metrics: nil, views: ["progressView" : progressView!]))
        progressContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[progressLabel]|", options: [], metrics: nil, views: ["progressLabel" : progressLabel!]))
        backgroundView.addSubview(progressContainer)
        
        backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal, toItem: progressContainer, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerX, relatedBy: .equal, toItem: progressContainer, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        window?.addSubview(backgroundView)
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|", options: [], metrics: nil, views: ["backgroundView" : backgroundView]))
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundView]|", options: [], metrics: nil, views: ["backgroundView" : backgroundView]))
    }
    
    //hide progress view
    public func hideProgressView(_ customView: UIView?) {
        var window: UIWindow?
        if customView != nil {
            window = customView as? UIWindow
        }
        else {
            window = returnTopWindow()
        }
        window?.viewWithTag(progressViewConfig.tag)?.removeFromSuperview()
        progressLabel = nil
        progressView = nil
    }
    
    //show spinner
    public func showSpinner(_ customView: UIView?) {
        
        var window = customView
        
        if (window == nil) {
            window = returnTopWindow()
        }
        if ((window?.viewWithTag(spinnerViewConfig.tag)) != nil) {
            return
        }
        
        //background view
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.tag = spinnerViewConfig.tag
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        window?.addSubview(backgroundView)
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|", options: [], metrics: nil, views: ["backgroundView" : backgroundView]))
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundView]|", options: [], metrics: nil, views: ["backgroundView" : backgroundView]))
        
        //spinner
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = spinnerViewConfig.color
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        backgroundView.addSubview(activityIndicator)
        backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    //hide spinner
    public func hideSpinner(_ customView: UIView?) {
        
        var window: UIWindow?
        
        if (customView != nil) {
            window = (customView as? UIWindow)
        }
        else {
            window = returnTopWindow()
        }
        window?.viewWithTag(spinnerViewConfig.tag)?.removeFromSuperview()
    }
}

// MARK: - Helper methods
extension AFNetwork {
    
    //set progress and text of progress view
    func setProgressProgress(_ fractionCompleted:Float) {
        
        self.progressView?.progress = Float(fractionCompleted)
        self.progressLabel?.text = String(format: "Uploading Image %.0f%%", fractionCompleted * 100)
    }
    
    //return top window
    func returnTopWindow() -> UIWindow {
        
        let windows: [UIWindow] = UIApplication.shared.windows
        
        for topWindow: UIWindow in windows {
            if topWindow.windowLevel == UIWindowLevelNormal {
                return topWindow
            }
        }
        return UIApplication.shared.keyWindow!
    }
    
    //return merge headers
    func mergeWithCommonHeaders(_ headers: [String : String]?) -> Dictionary<String, String> {
        
        if headers != nil {
            for header in headers! {
                AFNetwork.shared.commonHeaders[header.key] = header.value
            }
        }
        return AFNetwork.shared.commonHeaders
    }
}

// MARK: - extension for getting the domain name from a string
extension String {
    public func getDomain() -> String? {
        guard let url = URL(string: self) else { return nil }
        return url.host
    }
}