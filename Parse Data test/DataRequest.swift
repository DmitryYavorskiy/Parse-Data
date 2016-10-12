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
    
    static func getData(dictionaryDta: NSDictionary, methodName: MethodName, completionHandler:((_ succes: Bool, _ info: NSDictionary) -> Void)!) {
        
        let internetStatus = InternetConnection.checkInternetConnection()
        
        if internetStatus == true {
            switch methodName {
            case MethodName.getFeed:
                
                let offset = dictionaryDta.value(forKey: "offset")
                let limit =  dictionaryDta.value(forKey: "limit")
                
                let urlString = "\(API_URL)getfeed?offset=\(offset!)&limit=\(limit!)"
                
                APIRequest.getRequest(urlString: urlString, methodHttp: MethodHttp.get.rawValue, post: "", completionHandler: { (succes, info) in
                    if succes == true {
                        let errorMeta = (info.value(forKey: "meta") as? NSDictionary)?.value(forKey: "status") as! Int
                        if errorMeta == 200 {
                            DataMask.parseData(dictionary: info, type: .getFeed, completionHandler: { (succes: Bool, dict: NSDictionary) in
                                completionHandler(succes, dict)
                            })
                        } else {
                            print("errorMeta error")
                        }
                    } else {
                        print("succes error")
                    }
                })
                
                break
            default:
                print("error")
            }            
        } else {
            print("internet Error")
        }
    }
}
