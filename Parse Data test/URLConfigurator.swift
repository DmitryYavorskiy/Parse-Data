//
//  URLConfigurator.swift
//  Parse Data test
//
//  Created by media-pt on 28.10.16.
//  Copyright © 2016 media-pt. All rights reserved.
//

import Foundation

typealias UrlConfig = (urlString: String?, methodHttp: String)

struct URLConfigurator {
    
    static func configureUrl(dictionaryData: NSDictionary, dictHttpBody: NSDictionary?, methodName: MethodName) -> UrlConfig {
        
        switch methodName {
        case MethodName.getFeed:
            
            let offset = dictionaryData.value(forKey: "offset")
            let limit =  dictionaryData.value(forKey: "limit")
            
            let urlString = "\(API_URL)getfeed?offset=\(offset!)&limit=\(limit!)"
            ///add httpbody code
            return (urlString, MethodHttp.get.rawValue)
        default:
            return (nil, MethodHttp.get.rawValue)
        }
    }
}
