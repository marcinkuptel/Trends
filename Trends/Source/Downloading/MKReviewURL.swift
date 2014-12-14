//
//  MKReviewURL.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKReviewURL: NSObject {
   
    class func reviewURLFormat() -> String
    {
        return "https://itunes.apple.com/%@/rss/customerreviews/page=%i/id=%@/json"
    }
    
    class func reviewURL(appID: String, page: Int, store: String) -> NSURL
    {
        let urlString: String = String(format: self.reviewURLFormat(), store, page, appID)
        return NSURL(string: urlString)!
    }
}
