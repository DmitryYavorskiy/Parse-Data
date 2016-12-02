//
//  DataRequest.swift
//  Parse Data test
//
//  Created by media-pt on 07.10.16.
//  Copyright © 2016 media-pt. All rights reserved.
//

import Foundation
import UIKit

public enum MethodName: String {
    case getFeed
    case utc
}

enum MethodHttp: String {
    case get = "GET"
    case post = "POST"
}

struct DataRequest {
    
    static func getData(dictionaryData: NSDictionary, dictHttpBody: NSDictionary?, methodName: MethodName, completionHandler:((_ succes: Bool, _ info: NSDictionary) -> Void)!) {
        
        let internetStatus = InternetConnection.checkInternetConnection()
        
        if internetStatus == true || internetStatus == false {
            
            let configuration: UrlConfig = URLConfigurator.configureUrl(dictionaryData: dictionaryData, dictHttpBody: dictHttpBody, methodName: methodName)
            
            APIRequest.getRequest(urlString: configuration.urlString!, methodHttp: configuration.methodHttp, post: nil, completionHandler: { (succes, info) in
                
                if succes == true {
                    
                    let errorMeta = info.value(forKeyPath: "meta.status") as! Int
                    
                    if errorMeta == 200 {
                        DataMask.parseData(dictionary: info, type: methodName, completionHandler: { (succes: Bool, dict: NSDictionary) in
                            completionHandler(succes, dict)
                        })
                    } else {
                        print("errorMeta error")
                    }
                } else {
                    print("succes error")
                }
            })
        } else {
            print("internet Error")
        }
    }
}
