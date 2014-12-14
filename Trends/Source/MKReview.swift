//
//  MKReview.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKReview: NSObject {
   
    let content: String
    let title: String

    override var description: String {
        get {
            return "\(self.title)"
        }
    }
    
    init(reviewDict: Dictionary<String, AnyObject>)
    {
        let contentDict: Dictionary<String, AnyObject> = reviewDict["content"] as Dictionary<String, AnyObject>
        self.content = contentDict["label"] as String
        
        let titleDict: Dictionary<String, AnyObject> = reviewDict["title"] as Dictionary<String, AnyObject>
        self.title = titleDict["label"] as String
        
        super.init()
    }
    
    class func newReviewFromData(reviewDict: Dictionary<String, AnyObject>) -> MKReview?
    {
        var review: MKReview?
        if (reviewDict["content"] != nil && reviewDict["title"] != nil) {
            review = MKReview(reviewDict: reviewDict)
        }
        return review
    }
    
}
