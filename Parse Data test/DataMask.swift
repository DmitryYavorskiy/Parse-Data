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
            
            let pathArray = dictionary.value(forKeyPath: "responses.feed") as? NSArray
            let avatarUrl = pathArray?.value(forKey: "avatar_url") as? NSArray
            let name = pathArray?.value(forKey: "name") as? NSArray
            let userName = pathArray?.value(forKey: "user_name") as? NSArray
            
            dictData = ["avatarUrl" : avatarUrl ?? ["https://numpor.kaust.edu.sa/_layouts/KAUST_ResearchCenters_Template/images/DefaultPersonPhoto.png"], "name" : name ?? ["Palce"], "userName" : userName ?? ["User"]]
            
            completionHandler(true, dictData)
            
        default:
            print("error")
        }
    }
}
