//
//  MKReview.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKReviewData: NSObject {
   
    let content: String!
    let title: String!
    let rating: Int!
    let identifier: Int!

    override var description: String {
        get {
            return "\(self.title)"
        }
    }
    
    init?(reviewDict: Dictionary<String, AnyObject>)
    {
        super.init()
        
        let contentDict: Dictionary<String, AnyObject>? = reviewDict["content"] as? Dictionary<String, AnyObject>
        if let dict = contentDict {
            self.content = dict["label"] as String
        }else {
            return nil
        }
        
        
        let titleDict: Dictionary<String, AnyObject>? = reviewDict["title"] as? Dictionary<String, AnyObject>
        if let dict = titleDict {
            self.title = dict["label"] as String
        }else{
            return nil
        }
        
        let identifierDict: [String:AnyObject]? = reviewDict["id"] as? [String:AnyObject]
        if let dict = identifierDict {
            let s = dict["label"] as String
            self.identifier = s.toInt()
        }else{
            return nil
        }
        
        let ratingDict: [String:AnyObject]? = reviewDict["im:rating"] as? [String:AnyObject]
        if let dict = ratingDict {
            let s = dict["label"] as String
            self.rating = s.toInt()
        }else{
            return nil
        }
    }
    
}
