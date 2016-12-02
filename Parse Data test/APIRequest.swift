//
//  APIRequest.swift
//  Parse Data test
//
//  Created by media-pt on 07.10.16.
//  Copyright © 2016 media-pt. All rights reserved.
//

import Foundation
import UIKit

var API_URL = "http://old2015.revizor.novy.tv/api/v1/"
var APP_Ver = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
var IOS_VER = UIDevice.current.systemVersion

struct APIRequest {
    
    static func getRequest(urlString: String, methodHttp: String, post: String?, completionHandler:((_ succes: Bool, _ info: NSDictionary) -> Void)!) {
        
        let internetStatus = InternetConnection.checkInternetConnection()
        let cachePolicy: NSURLRequest.CachePolicy = internetStatus ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad
        
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        let url = URL(string: encodedString!)
        let request = NSMutableURLRequest(url: url!, cachePolicy: cachePolicy, timeoutInterval: 10.0)
        request.httpMethod = methodHttp
        
        if methodHttp == "POST" {
            let postData = post?.data(using: String.Encoding.utf8, allowLossyConversion: true)
            request.httpBody = postData
        }
        
        request.setValue("REVIZORAPP/\(APP_Ver!) IOS/\(IOS_VER)", forHTTPHeaderField: "User-agent")
        request.addValue("private", forHTTPHeaderField: "Cache-Control")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let requestData = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                    
                    completionHandler(true, requestData)
                    
                } catch {
                    
                    print(error)
                    let requestData = NSDictionary()
                    completionHandler(false, requestData)
                    
                }
            } else {
                let requestData = NSDictionary()
                completionHandler(false, requestData)
            }
        })
        
        task.resume()
    }
}
