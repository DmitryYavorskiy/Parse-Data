//
//  DataMask.swift
//  Parse Data test
//
//  Created by media-pt on 07.10.16.
//  Copyright © 2016 media-pt. All rights reserved.
//

import Foundation

struct DataMask {
    
    static func parseData(dictionary: NSDictionary, type: MethodName, completionHandler:((_ succes: Bool, _ info: NSDictionary) -> Void)!)  {
        
        switch type {
        case MethodName.getFeed:
            var dictData = NSDictionary()
            let pathDict = (dictionary.value(forKey: "responses") as? NSDictionary)?.value(forKey: "feed") as? NSArray
            
            let avatarUrl = pathDict?.value(forKey: "avatar_url") as? NSArray
            let name = pathDict?.value(forKey: "name") as? NSArray
            let userName = pathDict?.value(forKey: "user_name") as? NSArray
            
            dictData = ["avatarUrl" : avatarUrl, "name" : name, "userName" : userName]
            
            completionHandler(true, dictData)
            break
        default:
            print("error")
        }
    }
}
